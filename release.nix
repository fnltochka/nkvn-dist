# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T233231Z-b1410dae";
  version = "2026.9.0-rc.3";
  candidateSha = "eeb9abf1c68eb535663d1fa88abe95b59dc4b676";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-OewHtK+AdgonjNYe6pP3foMPcZ8IHSuX+bg4uhUg+mY=";
  signatureSha256 = "sha256-ExIgQO8SL9LZiJx4TqAz0r7b/jzQnWkfJyPVOgyMv6Y=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-jF1xs0mJsFYEbsVaHIBjV1l4lkSv308klXaWH/C0ZbE=";
    control = "sha256-0SRy1Zjb82KNml6s76++Gb2rNPfMADVf+eZCXtkA42s=";
    node-agent = "sha256-7i9ri9ZkgTK/eBLhycAWo7Q9epB0YhbWjsWx0mxpx00=";
    server = "sha256-23m3qiNoHNwqM+etCENSdR2CtN6FVS24zA+BmXSJjlU=";
  };
}
