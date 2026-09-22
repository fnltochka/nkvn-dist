# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260922T132558Z-4019e751";
  version = "2026.9.0-rc.7";
  candidateSha = "3f6963161c13a5a7e2459611c2e6635fa79d297b";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-Ea4wx0y+qkgHFCySJAc0nAe+ZxxVOm5xYzn4CvON9Ac=";
  signatureSha256 = "sha256-j+GYXrb/BdBvqzvav1qMaboFF62I1FGpLebtzICVs88=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-pGaub1diZBp7g/0hh1JWxNR+9xMTHMERcelA6JJaQOU=";
    control = "sha256-p+CJ9sqq4NbY/3hcYZRwuiM/GFmwChWg0obB7zR54qo=";
    node-agent = "sha256-0Kxw4WFOHARyf5TdSdoLM8FxNzmFQSJDzC5Ww4l7z4w=";
    server = "sha256-vy5hDcVfRhcoQ/UPuSZ0YPvrWu1LQk5bXTeUPO6iYA4=";
  };
}
