# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T235242Z-df38bc07";
  version = "2026.9.0-rc.3";
  candidateSha = "5600768a86fe76c511e4baec6f5d8bce6816c005";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-nrTm6gJFTQMY0I8eA45EUyBlUDAspJemu01jSwUHSLk=";
  signatureSha256 = "sha256-CpLdSljmPhY4zX+z9+ojOVJRQU3va9TYb0YcbsTpBXk=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-DSUK0T29E6PDdOMeeZ9s1jWO1CniuuarBPYlmYfUT6k=";
    control = "sha256-Bc6mKxjsLdzFaVbLi1Q5vrbUkO8xPdJARdKLy0S4InU=";
    node-agent = "sha256-m3Dh7mbjTcY83KAOx0DybtMCUU/GXEZzmDWSKlPU+fw=";
    server = "sha256-2Xc5nsSylPt92EJaWk8FJEERvy7EJKNuNBFKC3EFD7A=";
  };
}
