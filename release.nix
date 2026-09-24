# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260924T131610Z-44b754a3";
  version = "2026.9.0-rc.8";
  candidateSha = "079c338607fe6c44a46b78b78326413d6ae575fd";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-iecCOZHh1pRfWxsBb6nIclj3mHEpEluqZba9nzRjj6U=";
  signatureSha256 = "sha256-1EVmB++VpqR/z0LMMqErBRShsicX19zJuTm1WFhQ0r8=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-MLG84pVCJ0QzPPlWQ1zqVu1KQ2vx88R6JFHfrpGC/hY=";
    control = "sha256-Kay2slZD3SNkxH6CY4IYxQqhFYv25k2i5zy0WIIU80Q=";
    node-agent = "sha256-JCPT2h9AgMaFGR15c/txcdidaxTJuCPqIBficgFIdPk=";
    server = "sha256-mBWchV8PFLVJIbsZHnWBNn6noWYZWguF4nXhumhiZSY=";
  };
}
