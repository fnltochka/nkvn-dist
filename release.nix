# Pins for one immutable distribution release. Every value below is replaced
# when a new release is published; there is no mutable channel or latest
# lookup.
{
  releaseId = "20260921T004042Z-3e1dce66";
  version = "2026.9.0-rc.4";
  candidateSha = "35f8d3b6afc55b96b75d78d3a074479f207f15b7";
  authorityPublicKeyHex = "7240d3d5a8abf18e3c2559b26198d4db822060fd88615b21a1823d3c94ce0b4d";
  baseUrl = "https://nkvn.fnltochka.dev/v1/releases";

  # SRI hashes of the release manifest and its detached signature.
  manifestSha256 = "sha256-zUIQQj2UdY/yqJ0lWnR8wN2gUeGYY24V1YA6ux9UI84=";
  signatureSha256 = "sha256-nyCoOOqXyqL4f6bKeH+Y/HqgXAs3KSkVyYUr+jPCQQc=";
  # SRI hash per artifact role. Every signed binary in the release is pinned.
  artifactSha256 = {
    client = "sha256-9oMFLEYLgf/k5lCQticHd2XrBbTtmp4dRPDLpVH79p0=";
    control = "sha256-YA6QiqEUhHUfNldqjZ1ZUj91rQIsU0Ti2HECmT89hTQ=";
    node-agent = "sha256-np2zXHoJxo4u7c72SWqWL8XYkdN+FiBOszTTLz+1OXE=";
    server = "sha256-Zo1OyYTAxOYTS1nqDivvqDdOJjTQUN3cYDbNKNtfVUQ=";
  };
}
