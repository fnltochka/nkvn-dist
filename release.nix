# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260924T212627Z-6bf70253";
  version = "2026.9.0-rc.9";
  candidateSha = "8e515efcbe983624292945de8db39ab2508f9082";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-ViUxZefUGFjUOHB1dEXl0YPlnrbx8vi6KbUnCAwA4q0=";
  signatureSha256 = "sha256-v2KsMLpi0q3jdFGxO2xv4O4NZaFftauSYaGB/M9I3RA=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-ElUOs9i8OVbTr60J2nULy+mlsxhU9FAWWfpdadOF35c=";
    control = "sha256-F+YA4uLGENBJr+Wkbrwbt2oQHLqtqkbRlLFO74LyGBU=";
    node-agent = "sha256-DYyoLycIF0TDHZ5quEB7y24Oml2EYr+CNHrp8HYaFu0=";
    server = "sha256-53uftgsCzSfrmMaeUnvgp/J8Q+VnydQPa3p5o8xEiI8=";
  };
}
