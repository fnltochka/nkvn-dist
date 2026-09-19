# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T011507Z-7a9881c8";
  version = "2026.9.0-rc.3";
  candidateSha = "3155e7eca073531570528374d2145376e8404d4d";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-yGJ/OyBOAhWtDLPpr7whthUr2bvKDOZo7FTJ2j++/Nc=";
  signatureSha256 = "sha256-ELCiUquid5eijtZ65tmMfQnac1Cg/J/M2k3KEbb7eT8=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-zAB10ubfjjmbFAyTowLXmpIP5rcpstqkPLlAlkuTF18=";
    control = "sha256-si1xvG+4Mu2vrVOrd0rITcuqkXVwg7vWYTOIrhsI6ic=";
    node-agent = "sha256-N4c5YG6gfo8Nv3L4AB936PDqXhHhDCtnQc0dsnLFJsE=";
    server = "sha256-NgV4XTWCm4F04km+gJM/tlCwvxBctlZHQItylvrZKy0=";
  };
}
