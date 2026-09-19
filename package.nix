{
  lib,
  stdenvNoCC,
  fetchurl,
  coreutils,
  jq,
  libxml2,
  openssl,
  writeText,
  role,
  artifact,
  release ? import ./release.nix,
}:

let
  hashOrFake = value: if value == null then lib.fakeHash else value;
  manifest = fetchurl {
    name = "RELEASE-MANIFEST.json";
    url = "${release.baseUrl}/${release.releaseId}/RELEASE-MANIFEST.json";
    hash = hashOrFake release.manifestSha256;
  };
  signature = fetchurl {
    name = "RELEASE-MANIFEST.json.sig";
    url = "${release.baseUrl}/${release.releaseId}/RELEASE-MANIFEST.json.sig";
    hash = hashOrFake release.signatureSha256;
  };
  artifactFile = fetchurl {
    name = artifact;
    url = "${release.baseUrl}/${release.releaseId}/${artifact}";
    hash = hashOrFake (release.artifactSha256.${role} or null);
  };
  isClient = role == "client";
  # The client product configuration is derived from the pinned release rather
  # than kept as a second, manually synchronised copy.
  productConfig = writeText "product-config.toml" ''
    schema = "nkvn-client-product-v1"
    channel = "internal-beta"
    platform = "linux"
    runtime_resource_profile = "high-throughput"
    candidate_sha = "${release.candidateSha}"
    release_authority_public_keys_hex = [
      "${release.authorityPublicKeyHex}",
    ]
    packet_performance_tier = "development"
  '';
in
stdenvNoCC.mkDerivation {
  pname = artifact;
  version = release.version;
  src = artifactFile;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [
    coreutils
    jq
    openssl
  ] ++ lib.optionals isClient [ libxml2 ];

  installPhase = ''
    runHook preInstall
    set -euo pipefail

    manifest=${manifest}
    signature=${signature}
    binary=$src
    public_key=${./distribution-ed25519-public.pem}
    transcript="$TMPDIR/nkvn-distribution-transcript"
    canonical="$TMPDIR/nkvn-release-manifest.canonical"

    test -f "$manifest" && test ! -L "$manifest"
    test -f "$signature" && test ! -L "$signature"
    test -f "$binary" && test ! -L "$binary"
    test "$(stat -c %s "$signature")" -eq 64

    # The signature covers the exact manifest bytes, including its final LF.
    printf 'nkvn-distribution-v1\0' > "$transcript"
    cat "$manifest" >> "$transcript"
    openssl pkeyutl -verify -pubin -inkey "$public_key" -rawin \
      -in "$transcript" -sigfile "$signature"

    # jq's sorted compact form matches the producer's canonical JSON form.
    jq -cS . "$manifest" > "$canonical"
    cmp -s "$manifest" "$canonical"

    jq -e --arg release_id "${release.releaseId}" \
      --arg version "${release.version}" \
      --arg candidate_sha "${release.candidateSha}" \
      --arg target "x86_64-unknown-linux-musl" \
      --arg role "${role}" \
      --arg artifact "${artifact}" '
      (type == "object") and
      ((keys | sort) == [
        "artifacts", "channel", "createdUtc", "releaseId", "schema",
        "sequence", "sourceCommit", "sourceTree", "target", "version"
      ]) and
      .schema == "nkvn-distribution-v1" and
      .channel == "internal-beta" and
      .target == $target and
      .releaseId == $release_id and
      (.releaseId | test("^[A-Za-z0-9][A-Za-z0-9._-]{0,126}[A-Za-z0-9]$")) and
      (.createdUtc | test("^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$")) and
      .sourceCommit == $candidate_sha and
      (.sourceTree | test("^[0-9a-f]{40}$")) and
      (.releaseId | split("-") | last) == (.sourceTree[0:8]) and
      (.version == $version) and
      (.version | test("^20[0-9]{2}\\.(?:[1-9]|1[0-2])\\.(?:0|[1-9][0-9]*)(?:-[0-9A-Za-z.-]+)?$")) and
      (.sequence | numbers | floor == . and . >= 1) and
      (.artifacts | (type == "object" and
        (keys | sort) == ["client", "control", "node-agent", "server"])) and
      (.artifacts[$role] | (type == "object" and
        (keys | sort) == ["bytes", "name", "sha256"] and
        .name == $artifact and
        (.sha256 | test("^[0-9a-f]{64}$")) and
        (.bytes | numbers | floor == . and . >= 1 and . <= 134217728)))
    ' "$manifest"

    actual_sha256="$(sha256sum "$binary" | cut -d ' ' -f 1)"
    expected_sha256="$(jq -er --arg role "${role}" '.artifacts[$role].sha256' "$manifest")"
    test "$actual_sha256" = "$expected_sha256"
    actual_bytes="$(stat -c %s "$binary")"
    expected_bytes="$(jq -er --arg role "${role}" '.artifacts[$role].bytes' "$manifest")"
    test "$actual_bytes" = "$expected_bytes"

    install -Dm555 "$binary" "$out/bin/${artifact}"
    runHook postInstall
  '';

  postInstall = lib.optionalString isClient ''
    install -Dm444 ${productConfig} "$out/share/nkvn/product-config.toml"
    install -Dm444 ${./packaging/dbus/dev.nkvn.Client1.conf} \
      "$out/share/dbus-1/system.d/dev.nkvn.Client1.conf"
    install -Dm444 ${./packaging/polkit/dev.nkvn.policy} \
      "$out/share/polkit-1/actions/dev.nkvn.policy"

    test ! -e "$out/share/dbus-1/system-services/dev.nkvn.Client1.service"
    xmllint --nonet --noout \
      "$out/share/dbus-1/system.d/dev.nkvn.Client1.conf" \
      "$out/share/polkit-1/actions/dev.nkvn.policy"
  '';

  meta = {
    description = "nkvn Linux ${role} binary";
    homepage = "https://github.com/fnltochka/nkvn-dist";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = artifact;
  };
}
