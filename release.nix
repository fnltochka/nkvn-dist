# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260922T003343Z-e2c6a9e3";
  version = "2026.9.0-rc.7";
  candidateSha = "7ad87a3a0940aef04a8ccb95355ffeaa74b7fcfe";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-vFwPaRG8KdT9LE8tm/RHV9GAqPmY+P/looQkOJHj8YY=";
  signatureSha256 = "sha256-WsBds3p1vx/hJfUx771nxS4qm3h5VTTVqsXwLUEfjgM=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-xi2jRbXk1gEPr1z+TYbyP2EmCW/0aZOdFgPiuXehJWo=";
    control = "sha256-w+vAGwfU5PxZbFiij0Gkck++nOFalNuj43bDO13Jpqs=";
    node-agent = "sha256-gW+1P8yWfQOVhg1a5j6pjqvTSjCkKgcrohzyCvVcvaw=";
    server = "sha256-L2YMN846ypH3/9818ti0NuvX0f/7i5DH8+xI1o73YbA=";
  };
}
