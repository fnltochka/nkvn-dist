# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260920T164645Z-6262484f";
  version = "2026.9.0-rc.3";
  candidateSha = "ad4168b28ab92358a843797c49b4ba6c597a4c91";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-BHPx0fnSqx+1F29WvF5Gkcs1/riJFVdEAirslLVWOmU=";
  signatureSha256 = "sha256-rjie2+SJJ4dg4OabyyOY75Nzh0EuZt8q5/Tqt6BAuAk=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-tliDtvyrhY0xe//1FkDZp5OpSnoM7bfcQ/2bY9gTKPw=";
    control = "sha256-bZRXt9MyWzqjqActNLbBKNIbXqMtqSW3qXh2NDL9pu0=";
    node-agent = "sha256-wGEF7Fd/8XXsdwQUfod1jMgHNZhQYyBhHRrWZxtPnVM=";
    server = "sha256-fRjRs5ZUTklXo1gvQE2DgbTXeoGCiW+rMVH+qSvmi5c=";
  };
}
