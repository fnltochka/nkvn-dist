# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T221401Z-1113a745";
  version = "2026.9.0-rc.3";
  candidateSha = "42945e661d7cb6b99621c2b99ff0c6d5e553458b";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-OcDzPu/gNlhTJg1CjyySll/wVOTOkDDHil7Uv4W0S3I=";
  signatureSha256 = "sha256-XVvQ1wBRTqskKV9yLZjxLDHUDqmTJq30GSDwE0MAGYs=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-2Xs/K0e6DDy3uoLLt6ttE4/99fMvo5P5GjJw7JD+W64=";
    control = "sha256-6Lb3heq3tMt2QLLS4yjgmjank+z79l147v8+U9owBb0=";
    node-agent = "sha256-uEWpBfODB9wA/0Ego+Q3vjypr/D2G5JHsm1vu88lULE=";
    server = "sha256-3sYtygh4wwSiatLrnED8lhEEnOw4kXz1uxRgvM44HFE=";
  };
}
