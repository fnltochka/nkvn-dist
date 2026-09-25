# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260925T192148Z-32ab1a39";
  version = "2026.9.0-rc.12";
  candidateSha = "616f81161a626ad524eb7680272d1fee721847eb";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-tfWgeDglOKHN18RbFUYVjlQ+02LJ44Y3RuD3ASIdb5w=";
  signatureSha256 = "sha256-rSr1ojhcjgRaqkr3FWBTjmzsdItFivr2/vq8u4Aeh18=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-FHyUZaLH9ZI8dPpxuxwoSdPqumda/F8656UeJaUUAXM=";
    control = "sha256-iYITSaAWYBjq8Mp9KVgrtx8IVwZC6f160qrZPTe3JcI=";
    node-agent = "sha256-0X44WIBhtB4kRwKPueBT/lZWgwRZwDiCm3S/dRx4AyU=";
    server = "sha256-j0HnxTVR89RpHHZRPuK0FHyaOhy506c3Q/YnanOhVUo=";
  };
}
