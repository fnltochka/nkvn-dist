# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260925T070124Z-19227bc5";
  version = "2026.9.0-rc.10";
  candidateSha = "a24719a8bb060f67d2c50215ad5013236e77018c";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-c3rJTAvQoWBnHinaEGVUB645tZG5E9iYMj8jNf/p8yk=";
  signatureSha256 = "sha256-7uxhmCXWvgSjnj3muO0cJsUQnjKS8c5N8IiazdmMe+4=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-6FKtgvk6kJYMuPfm3Q4Um9tXOQJzoNN2QWspS3BMab0=";
    control = "sha256-bZIVcxRcxEIGVXJX48JWSlHv5ABNdGHCBIX0oH5myFE=";
    node-agent = "sha256-sXjY3Liypu/MyNFKaYxua8uI/NbPposDXb/WLz8j5pA=";
    server = "sha256-kls715sG7RoK5zc9LLbQtoE7SnQdlZWLTQh8Wn8zAr0=";
  };
}
