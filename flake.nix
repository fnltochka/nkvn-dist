{
  description = "nkvn signed binary distribution and Nix packaging";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs =
    { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs systems;
      # Short role name -> signed binary in a distribution release.
      roles = {
        client = "nkvn-client";
        control = "nkvn-control";
        node-agent = "nkvn-node-agent";
        server = "nkvn-server";
      };
      packagesFor =
        pkgs:
        nixpkgs.lib.mapAttrs (
          role: artifact:
          pkgs.callPackage ./package.nix {
            inherit role artifact;
          }
        ) roles;
    in
    {
      packages = forEachSystem (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          packages = packagesFor pkgs;
        in
        packages // { default = packages.client; }
      );

      nixosModules.default = import ./nixos-module.nix;

      formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

      checks = forEachSystem (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          moduleConfig =
            (nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                self.nixosModules.default
                {
                  nixpkgs.config.allowUnfree = true;
                  programs.nkvn-client.enable = true;
                  services.resolved.enable = true;
                  services.nkvn-client = {
                    enable = true;
                    alwaysOn = true;
                    earlyGuard = true;
                    configFile = ./tests/client.toml;
                  };
                }
              ];
            }).config;
        in
        {
          distribution-contract =
            pkgs.runCommand "nkvn-distribution-contract"
              {
                nativeBuildInputs = [
                  pkgs.coreutils
                  pkgs.gnugrep
                ];
              }
              ''
                test -f ${./distribution-ed25519-public.pem}
                test -f ${./release.nix}
                test -f ${./package.nix}
                test -f ${./nixos-module.nix}
                test -f ${./packaging/dbus/dev.nkvn.Client1.conf}
                test -f ${./packaging/polkit/dev.nkvn.policy}
                test -f ${./tests/client.toml}
                grep -F 'nkvn-distribution-v1\0' ${./package.nix}
                grep -F 'earlyGuard' ${./nixos-module.nix}
                grep -F 'services.nkvn-client' ${./nixos-module.nix}
                mkdir -p "$out"
              '';

          client-module =
            assert builtins.elem pkgs.coreutils moduleConfig.systemd.services.nkvn-client.path;
            assert builtins.elem pkgs.nftables moduleConfig.systemd.services.nkvn-client.path;
            assert builtins.hasAttr "nkvn-client-guard" moduleConfig.systemd.services;
            assert nixpkgs.lib.hasInfix "--always-on" (
              toString moduleConfig.systemd.services.nkvn-client.serviceConfig.ExecStart
            );
            pkgs.runCommand "nkvn-client-module"
              {
                nativeBuildInputs = [ pkgs.gnugrep ];
              }
              ''
                test ${nixpkgs.lib.escapeShellArg (builtins.toJSON moduleConfig.systemd.services.nkvn-client.requires)} = '["nkvn-client-guard.service"]'
                test ${nixpkgs.lib.escapeShellArg moduleConfig.systemd.services.nkvn-client-guard.serviceConfig.Type} = oneshot
                test ${nixpkgs.lib.escapeShellArg (builtins.toJSON moduleConfig.systemd.services.nkvn-client.wants)} = \
                  '["network-pre.target","nkvn-client-always-on.service","systemd-resolved.service"]'
                mkdir -p "$out"
              '';
        }
      );
    };
}
