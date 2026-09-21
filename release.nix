# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260921T132859Z-63eb2fb1";
  version = "2026.9.0-rc.6";
  candidateSha = "523593004f48454a38ddf8f95bc63190947c4e39";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-ZQZZIyN7/h09/pH94C75g56fMUmELsfRtE2MtrsAtu4=";
  signatureSha256 = "sha256-KE+XaABGJA8zI9KE8vTBAMrKiktf8SRkc/PJuCaiKSE=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-jM6V6W5R2+5eZuIfYMi3R/WAaFcAhqRHwgvpyZ73pYc=";
    control = "sha256-TqTZ/8egkL2ULDKd9+HVVrsqWf0Rb9sEx+/H6xZpKhw=";
    node-agent = "sha256-RLq1FlMG5bWSFVs/x+I1cspQTrEJTH4sqHXzaU6Kb4k=";
    server = "sha256-FZWycnzTMV7spFjZNW2RkitKBQlSMm0+oEsuUMMeQyk=";
  };
}
