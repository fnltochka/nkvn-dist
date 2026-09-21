# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260921T144502Z-08ca8049";
  version = "2026.9.0-rc.7";
  candidateSha = "eee721868a58740058dfa99a0b38013b0decd653";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-wRupLj3H7wGJtafbCnLfyDQiiHPYM8vrhh+/Oyf4Gos=";
  signatureSha256 = "sha256-MK8Zl/hwicRr8m8VOC7ipJV06o+cZZB2MRBI8kDOcTk=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-eCiMn1JsE0L2cS3ErYHxzSAfHTaS3NWkG28AACQwtd0=";
    control = "sha256-GW1LUW7bXj8vFk0vn/el9HnqqnvbnGvAV2wotVTYY4o=";
    node-agent = "sha256-ydEH4UdAljojs6Xt7lYPewBeut6J2UT1tPFVcyxz1U0=";
    server = "sha256-GbK14x0cmDpS56IJpr5P6LHQ20gtxCDoZjDO6fvqCkM=";
  };
}
