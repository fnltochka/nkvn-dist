# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260921T020930Z-5d97e7c5";
  version = "2026.9.0-rc.5";
  candidateSha = "bb47fc5ba33ed8337b8a065ae01d1857248c1818";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-OSIdu33jQXimed2dr2XIWefqIHcLx3+IIdg+iM2B/nc=";
  signatureSha256 = "sha256-dXW4q+UwQBZ6VW4GWCEqFhcf7eNy4fzVPhj95pOakLs=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-BKvTcCUNovqkHEw3nFLEaXx5IfQ1SIKufpgyFyHqioQ=";
    control = "sha256-KpBj5DEITv30xa7S21RWWXGzLuEZqQm50QnXy59EA1Q=";
    node-agent = "sha256-OAArEZb5Cy0Htx4f7ju5y0KMSfP1fLtBMAjMsQW16K8=";
    server = "sha256-7KV8A/ajBmP8glnf+4UT2tk+F589R19tbzE/poMgQ0A=";
  };
}
