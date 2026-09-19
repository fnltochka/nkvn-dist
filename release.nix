# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T202248Z-5ca91fb3";
  version = "2026.9.0-rc.3";
  candidateSha = "416ed57d7b25c9703f3b04142175b5644374da7e";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-7/52hMAKD0I4Hi9e1u+wCJTv0JyaugsOEm0e/qFtqhk=";
  signatureSha256 = "sha256-YUukqDpjIs1+4njMWZwV1zcvRc21Ql618GuWSWRH6co=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-5eFQW9wlXzneqgLOJXfhT6WUa7qb9mddASv6g9re7nQ=";
    control = "sha256-D45GZXltr4LGRJ1DTrWNBDkhQByYdn2DP1ySGShvAm8=";
    node-agent = "sha256-bi9Umtg9XeskrJE76Agg4wa5jTUWyydMXd2z0zZeQ0Q=";
    server = "sha256-gNWZJS+gqrNeQuY9A4vaRqEdCt46CW16CEwT45lIxzc=";
  };
}
