# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260922T200954Z-32f633ac";
  version = "2026.9.0-rc.7";
  candidateSha = "29673623634b3defac04d590062693c5d31b8728";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-FZc2appCqaPYtWNnMXYawgzJuz3z8y05s8RaJGjvQxA=";
  signatureSha256 = "sha256-4dlquD7pxZLrmjXqMEMlVMOLk+bIoWXTIA/h93bZq18=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-dXifoDWkJsoeURZ7H5VXYoMYl5+11Uy2KZlzQgfuw4Q=";
    control = "sha256-VGU1aCnjMWPpmIPoRlfL04KEFTKs5VDkagEfEPBd2Mw=";
    node-agent = "sha256-n6MG1Flk+ACJebhpYWMTacNeDwlkZmWEZQMNTLOzhMw=";
    server = "sha256-e+h6fHu077rJNgkeHQSJX1NFZctd+hT+1N0c1RYphXQ=";
  };
}
