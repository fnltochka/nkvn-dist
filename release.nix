# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T001127Z-20b34fd5";
  version = "2026.9.0-rc.3";
  candidateSha = "42c4bb47a63c82dfb82c1d7c76159be00edab182";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = null;
  signatureSha256 = null;
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = null;
    control = null;
    node-agent = null;
    server = null;
  };
}
