# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260922T145009Z-40eeb15d";
  version = "2026.9.0-rc.7";
  candidateSha = "79652a14737c0c51db47a6797507c4a02b131df8";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-QFjaNhwp2WphQRHC20ia17VoClfFN9fmsgqhB5vnJ/s=";
  signatureSha256 = "sha256-QVHa/H/5nOBRw/LDhhfit9feY2Dsq/AWdToML123020=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-8rykooVVbvoD4D1PTeBQ8i7okC5hh/UKq72WvN8M67Q=";
    control = "sha256-xqi4M+yEuhfaRVzyaNUScKP3CVb6cNFuoeu/spHKgmw=";
    node-agent = "sha256-sT7id/eF+6XrNIDacSSCDs7gGlXbkO70NAyXPJeEX3c=";
    server = "sha256-4C/hdkhoaclTU5K4apaJ/HoItaCy2cjYtfMZm4f1v+c=";
  };
}
