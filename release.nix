# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260921T230731Z-8486c129";
  version = "2026.9.0-rc.7";
  candidateSha = "4da9319ce3ad1c2ca663257651235d1d05440004";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-Gj4RlVWKA5+hop9BE2ZlfKPnyq7zdsWy6/XUUdBRJvc=";
  signatureSha256 = "sha256-PqbXVFxgCsoLN/T233gBJjPe1vm6FlRCRHGKRZw9lh4=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-k0zDUDZp6CXXdBhJEFMM1XRg99tTiNPezT7wWYJ6Px4=";
    control = "sha256-iOveTTesaGTG+qY/qqxqSAALqvr5CmPEWJ10WwXTfw8=";
    node-agent = "sha256-Sc2ooH/mPHPte/4FL7jOcdptdEv88cUXBuFUQljmsG4=";
    server = "sha256-eVajqWS/xj0MEvxzya5aYmzKJ8MPceR+78XX43IoTmg=";
  };
}
