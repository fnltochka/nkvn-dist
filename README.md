# nkvn-dist

Signed nkvn distribution: the `nkvn-client`, `nkvn-control`,
`nkvn-node-agent` and `nkvn-server` binaries for
`x86_64-unknown-linux-musl`.

This is not NixOS-only: the binaries can be downloaded and installed directly on any
Linux. The Nix flake and NixOS module are just one consumer.

## Directly

```console
base=https://nkvn.fnltochka.dev/v1/releases/<releaseId>

curl -fLO $base/RELEASE-MANIFEST.json
curl -fLO $base/RELEASE-MANIFEST.json.sig
curl -fLO $base/nkvn-client

# the signature covers the domain and the exact manifest bytes
{ printf 'nkvn-distribution-v1\0'; cat RELEASE-MANIFEST.json; } > transcript
openssl pkeyutl -verify -pubin -inkey distribution-ed25519-public.pem -rawin \
  -in transcript -sigfile RELEASE-MANIFEST.json.sig

sha256sum -c <(jq -r '"\(.artifacts.client.sha256)  nkvn-client"' RELEASE-MANIFEST.json)
install -Dm555 nkvn-client /usr/local/bin/nkvn-client
```

The other roles work the same way (`control`, `node-agent`, `server`).

## Nix

```nix
inputs.nkvn-dist.url = "github:fnltochka/nkvn-dist";

inputs.nkvn-dist.packages.${pkgs.system}.client
inputs.nkvn-dist.packages.${pkgs.system}.control
inputs.nkvn-dist.packages.${pkgs.system}.node-agent
inputs.nkvn-dist.packages.${pkgs.system}.server
inputs.nkvn-dist.nixosModules.default   # client module
```

Every package verifies the manifest signature, the release identity and the artifact
SHA-256 and byte size. One release is pinned in `release.nix`; the client product
configuration is derived from that pin instead of a second, manually synchronised copy.
The client module installs dbus/polkit and the product config;
`services.nkvn-client.earlyGuard` adds the guard before `network-pre.target`.
