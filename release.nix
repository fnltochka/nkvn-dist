# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260925T140524Z-e8e71317";
  version = "2026.9.0-rc.11";
  candidateSha = "9f34ca95ac1e0fbe02878eadbddfd53ea26e896f";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-rVHG3qHlGB2fZHTo4DJKZgPEp4IBJWvVR+HdQYONZtI=";
  signatureSha256 = "sha256-isEpwW14tcVdjGXlZnWvGwuOsvtFkSm420h1D6wOLtc=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-XVXRt/pnia4w52kt+/dQg8naqGS2fEM3XUoqOG0imnE=";
    control = "sha256-NvIjRnRjpKWW4i7H04te8xVN1Dpqy9ZDx1UUwpV6avk=";
    node-agent = "sha256-j43+WHDmHCetGBGpgKPNNHPnZY9H+Pu+nRdiSSe8o/U=";
    server = "sha256-wwUVQruwjHcQKw+vSnXRCForkqL3x/zsxKoK8OljE/w=";
  };
}
