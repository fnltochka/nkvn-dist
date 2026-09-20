# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260920T133508Z-201a4225";
  version = "2026.9.0-rc.3";
  candidateSha = "50b7e3b4a386a6ba7cfa416e3a90706acd79067a";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-Xe2Tj6zdIF6Yuq3uaPEuWGnWGjXDAQwm3uDAVPOkCVI=";
  signatureSha256 = "sha256-83oiNU3q4aiXYRab/y6wekeLZ8BmoMaqXOhq3RKEdZg=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-6wdEbYpLkjixvCV2ZB1bu0FtVAnURgo9cpwwf2btotA=";
    control = "sha256-LmhUDZKXlG8f+rU09GfI+FpxB+zBXTXFiH+qdvQGj28=";
    node-agent = "sha256-rFFAlBtQLqFcCzNtGqDIPIvHOnfWRRfC+FzM2OZAuNk=";
    server = "sha256-VS6mdi6oDJF7R5cOfDkiDXNGazNCwkB3evQqhUdlFeo=";
  };
}
