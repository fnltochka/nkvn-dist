# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260919T210844Z-48f3ebf2";
  version = "2026.9.0-rc.3";
  candidateSha = "6b1370ae3db7ea8158424e320cebff48b5c36b72";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-hoEf8lD3oFQBgTP4nbqD8OcNYBYhX48QgcdFD7Z4eIE=";
  signatureSha256 = "sha256-+iS8Xq3RJe2qovPetG0uWyUuIUHWJnuLji0FT2TrPYM=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-WtoaEF9jBS1LRbsREfqiqcGZ1NKQN7xvIZNtU4lMuLc=";
    control = "sha256-Me6KOphyUnN/RmViWm83iUHk9/pcYf0Fc8y21FwzdUE=";
    node-agent = "sha256-8XGKyzRac4/Z/NQyJF+vJNjZS+8vlJhcv6DvkJA+gRc=";
    server = "sha256-8+uTI1VFrZUn79RHzQuxIhdm7pr1g8GIJWe1oAUm0DM=";
  };
}
