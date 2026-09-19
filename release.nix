# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T213728Z-50f3260a";
  version = "2026.9.0-rc.3";
  candidateSha = "fd9c4ee7471dd1ed359a7adca0f63f00c5a680e5";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-gOa/gNe8R/Jyfvob2e5IcEVpSk/D+uSwg97PWHiVHuo=";
  signatureSha256 = "sha256-wwLnS9fAjiLnEQeb+qRd1SVrVsVl2a4UkpCJqLrtrKU=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-NInhFaFC8PtxehAGICgogvntCclsHedTfC3RPEz4eZA=";
    control = "sha256-9qyQX91+Z0qcrCiw+nXtS1LtemPQf58PmBdwgyskRX8=";
    node-agent = "sha256-4g7ZQjyNwKMzZGQIbfO3DQJul0dEkq2LIvZ1No6Bfuc=";
    server = "sha256-oWAoqJnxNiw96gPuPcTgyieOe39P0NoSllZahmavwCo=";
  };
}
