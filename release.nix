# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260921T234152Z-0cdf15fe";
  version = "2026.9.0-rc.7";
  candidateSha = "1a3d88c6da959aaa754c29445fdf763e65f1d988";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-6Mu6i9M4jPhCc39CcEyf6x8x3YsOP4U+mXb99ZoEfuQ=";
  signatureSha256 = "sha256-OXjMsiavYZrupmAKhPStMD0szQ8SCBYIW+3heHphmBM=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-AU5Z8G5p64Xqv3iBguaor0yYVV2sUXa8NbdiKGP98fc=";
    control = "sha256-S2pZEUu2+E2GAQvje+zRkB4sUPXtUdLBeIHA3N9wA4E=";
    node-agent = "sha256-EPG/IztXc0OhPp6dd+i8V8O8q5bwdFKx3vP/nV1XcZc=";
    server = "sha256-/ALfHMaxOxeR1CVl7HvqwQ3QB2GIy4R9Fy48Kcdnu74=";
  };
}
