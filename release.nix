# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T220038Z-cddec0fb";
  version = "2026.9.0-rc.3";
  candidateSha = "710137d61f9d0058e666c145700ec97f8c14a6dc";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-Y5c/v7M3CEfdn5EHCfHdG/mbOLNuXEYgirVoo8qh0yg=";
  signatureSha256 = "sha256-8ODiZjHYhBI3SdE55DlAlN0zThmoA+K4Ow7bxCiW2SY=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-JFB5L377exPtRuZpdRDoMxgZVzZ11Ljvc8NfKj42j0o=";
    control = "sha256-xyPn9zxprUBA9QzNL8/n73xyJTA9IpdFecCFtLsX0a8=";
    node-agent = "sha256-nVqP8gK891w6/Ctt4/LOWT7JtD4vtlQ5JfhcY9fQ+tg=";
    server = "sha256-J4jB3cCXk9hW/0AvfKMvLww4e5kWl3Gwcevyb0cdlZg=";
  };
}
