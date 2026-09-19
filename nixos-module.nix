{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.nkvn-client;
  service = config.services.nkvn-client;
  isNormalizedAbsolutePath =
    value:
    let
      components = lib.splitString "/" value;
    in
    builtins.isString value
    && lib.hasPrefix "/" value
    && value != "/"
    && lib.all (component: component != "" && component != "." && component != "..") (
      lib.tail components
    );
  clientConfig =
    if service.enable then builtins.fromTOML (builtins.readFile service.configFile) else { };
  clientStateDirectory = clientConfig.state_directory or null;
  clientStateDirectoryIsValid =
    clientStateDirectory != null
    && isNormalizedAbsolutePath clientStateDirectory
    && lib.hasPrefix "/var/lib/" clientStateDirectory;
  clientStateDirectories =
    if clientStateDirectoryIsValid then
      let
        components = lib.splitString "/" (lib.removePrefix "/var/lib/" clientStateDirectory);
      in
      lib.genList (index: lib.concatStringsSep "/" (lib.take (index + 1) components)) (
        builtins.length components
      )
    else
      [ ];
  # A gateway config owns IPv4 forwarding and its persistent guard requires
  # forwarding to be enabled. The host-only downgrade reconciliation disables
  # forwarding before installing protection, which cannot work for a gateway;
  # gateways rely on the declarative sysctl and the early-protection guard.
  isGateway = clientConfig ? gateway;
  forwardingTransitionState = "/run/nkvn/forwarding-transition.v1";
  restoreForwarding = pkgs.writeShellScript "nkvn-client-restore-forwarding" ''
    set -u

    state=${lib.escapeShellArg forwardingTransitionState}
    if [[ ! -f "$state" ]]; then
      exit 0
    fi
    receipts=/run/nkvn/protection-owners.v1
    if [[ ! -d "$receipts" ]]; then
      echo "refusing to restore forwarding without protection receipts" >&2
      exit 1
    fi
    shopt -s nullglob
    entries=("$receipts"/*)
    hosts=("$receipts"/host.*)
    gateways=("$receipts"/gateway.*)
    if (( ''${#entries[@]} != 1 || ''${#hosts[@]} != 1 || ''${#gateways[@]} != 0 )) \
      || [[ ! -f "''${hosts[0]}" || -L "''${hosts[0]}" ]]; then
      echo "refusing to restore forwarding before exact host-only protection is confirmed" >&2
      exit 1
    fi
    ipv4=
    ipv6=
    trailing=
    if ! IFS=' ' read -r ipv4 ipv6 trailing <"$state"; then
      echo "failed to read saved forwarding state" >&2
      exit 1
    fi
    case "$ipv4:$ipv6:$trailing" in
      0:0:|0:1:|1:0:|1:1:) ;;
      *)
        echo "saved forwarding state is invalid" >&2
        exit 1
        ;;
    esac

    status=0
    ${pkgs.procps}/bin/sysctl -q -w "net.ipv4.ip_forward=$ipv4" || status=1
    ${pkgs.procps}/bin/sysctl -q -w "net.ipv6.conf.all.forwarding=$ipv6" || status=1
    if [[ "$status" -eq 0 ]]; then
      rm -f -- "$state"
    fi
    exit "$status"
  '';
  reconcileHostOnlyDowngrade = pkgs.writeShellScript "nkvn-client-reconcile-host-only" ''
    set -eu

    if [[ "$#" -ne 1 ]]; then
      echo "usage: $0 CLIENT_CONFIG" >&2
      exit 2
    fi
    client_config="$1"
    state=${lib.escapeShellArg forwardingTransitionState}
    receipts=/run/nkvn/protection-owners.v1

    if [[ ! -f "$state" ]]; then
      if [[ ! -d "$receipts" ]]; then
        exit 0
      fi
      shopt -s nullglob
      gateways=("$receipts"/gateway.*)
      if (( ''${#gateways[@]} == 0 )); then
        exit 0
      fi

      ipv4="$(${pkgs.procps}/bin/sysctl -n net.ipv4.ip_forward)"
      ipv6="$(${pkgs.procps}/bin/sysctl -n net.ipv6.conf.all.forwarding)"
      case "$ipv4:$ipv6" in
        0:0|0:1|1:0|1:1) ;;
        *)
          echo "kernel forwarding state is not binary" >&2
          exit 1
          ;;
      esac

      temporary="$state.new"
      rm -f -- "$temporary"
      umask 0077
      printf '%s %s\n' "$ipv4" "$ipv6" >"$temporary"
      chmod 0600 "$temporary"
      mv -fT -- "$temporary" "$state"
    fi

    ${pkgs.procps}/bin/sysctl -q -w net.ipv4.ip_forward=0
    ${pkgs.procps}/bin/sysctl -q -w net.ipv6.conf.all.forwarding=0
    ${cfg.package}/bin/nkvn-client protection install --config "$client_config"
  '';
in
{
  options.programs.nkvn-client = {
    enable = lib.mkEnableOption "the nkvn client package";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./package.nix {
        role = "client";
        artifact = "nkvn-client";
      };
      defaultText = lib.literalExpression ''
        pkgs.callPackage ./package.nix { role = "client"; artifact = "nkvn-client"; }
      '';
      description = "Package to install for the nkvn client.";
    };
  };

  options.services.nkvn-client = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the declarative nkvn client daemon.";
    };

    earlyGuard = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Install the finite protection guard before network-pre.target and make
        the client daemon require it. The default keeps early boot soft: the
        daemon still performs its own finite protection reconciliation when it
        starts.
      '';
    };

    alwaysOn = lib.mkEnableOption ''
      declarative reconnection whenever the selected managed network is ready;
      this policy intentionally overrides a manual client down action
    '';

    configFile = lib.mkOption {
      type = lib.types.path;
      description = ''
        Evaluation-time-readable public client TOML. Its state_directory must
        be normalized and strictly below /var/lib. Secrets and enrollment
        state are not part of this public module.
      '';
    };

    productConfigFile = lib.mkOption {
      type = lib.types.path;
      default = "${cfg.package}/share/nkvn/product-config.toml";
      defaultText = lib.literalExpression ''
        "${config.programs.nkvn-client.package}/share/nkvn/product-config.toml"
      '';
      description = ''
        Immutable client product TOML containing the release authority,
        candidate identity, platform, and performance tier. The default is the
        product configuration shipped by the pinned client package.
      '';
    };
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = !service.alwaysOn || service.enable;
          message = "services.nkvn-client.alwaysOn requires services.nkvn-client.enable.";
        }
        {
          assertion = !service.earlyGuard || service.enable;
          message = "services.nkvn-client.earlyGuard requires services.nkvn-client.enable.";
        }
      ];
    }
    (lib.mkIf cfg.enable {
      environment.systemPackages = [ cfg.package ];
    })
    (lib.mkIf service.enable {
      assertions = [
        {
          assertion = cfg.enable;
          message = "services.nkvn-client.enable requires programs.nkvn-client.enable.";
        }
        {
          assertion = pkgs.stdenv.hostPlatform.isLinux;
          message = "services.nkvn-client currently supports NixOS/Linux only.";
        }
        {
          assertion = clientStateDirectoryIsValid;
          message = "services.nkvn-client.configFile must declare one normalized state_directory below /var/lib.";
        }
      ];

      services.dbus.packages = [ cfg.package ];
      security.polkit.enable = true;
      boot.kernelModules = [ "tun" ];

      warnings = lib.optional (!config.services.resolved.enable) ''
        nkvn will leave /etc/resolv.conf and host DNS operator-managed.
        Direct protection can start in this mode with a runtime warning;
        Strict protection requires a working systemd-resolved stub.
      '';

      systemd.services.nkvn-client-guard = lib.mkIf service.earlyGuard {
        description = "nkvn persistent client protection";
        path = [
          pkgs.coreutils
          pkgs.nftables
        ];
        requiredBy = [ "network-pre.target" ];
        before = [
          "network-pre.target"
          "nkvn-client.service"
        ];
        after = [
          "local-fs.target"
          "nftables.service"
        ];
        unitConfig.DefaultDependencies = false;
        restartTriggers = [
          service.configFile
          service.productConfigFile
        ];
        restartIfChanged = false;
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          LoadCredential = "client.toml:${service.configFile}";
          ExecStart = "${cfg.package}/bin/nkvn-client protection install --config %d/client.toml";
          ExecStop = "${cfg.package}/bin/nkvn-client protection purge";
          User = "root";
          Group = "root";
          RuntimeDirectory = "nkvn";
          RuntimeDirectoryMode = "0700";
          RuntimeDirectoryPreserve = "yes";
          StateDirectory = clientStateDirectories;
          StateDirectoryMode = "0700";
          UMask = "0077";
          TimeoutStartSec = "6s";
          TimeoutStopSec = "6s";
        };
      };

      systemd.services.nkvn-client = {
        description = "nkvn client daemon";
        path = [
          pkgs.coreutils
          pkgs.nftables
        ];
        wantedBy = [ "multi-user.target" ];
        requires = lib.optionals service.earlyGuard [ "nkvn-client-guard.service" ];
        wants = [
          "network-pre.target"
        ]
        ++ lib.optionals service.alwaysOn [ "nkvn-client-always-on.service" ]
        ++ lib.optionals config.services.resolved.enable [ "systemd-resolved.service" ];
        after = [
          "dbus.socket"
          "network-pre.target"
        ]
        ++ lib.optionals service.earlyGuard [ "nkvn-client-guard.service" ]
        ++ lib.optionals config.services.resolved.enable [ "systemd-resolved.service" ];
        restartTriggers = [
          service.configFile
          service.productConfigFile
        ];
        serviceConfig = {
          Type = "dbus";
          BusName = "dev.nkvn.Client1";
          LoadCredential = [
            "client.toml:${service.configFile}"
            "product.toml:${service.productConfigFile}"
          ];
          ExecStartPre =
            lib.optionals (!isGateway) [ "${reconcileHostOnlyDowngrade} %d/client.toml" ]
            ++ [
              "${cfg.package}/bin/nkvn-client protection recover-routing"
            ]
            ++ lib.optionals (!isGateway) [ restoreForwarding ];
          ExecStart = lib.escapeShellArgs (
            [
              "${cfg.package}/bin/nkvn-client"
              "daemon"
              "--config"
              "%d/client.toml"
              "--product-config"
              "%d/product.toml"
            ]
            ++ lib.optional service.alwaysOn "--always-on"
          );
          User = "root";
          Group = "root";
          RuntimeDirectory = "nkvn";
          RuntimeDirectoryMode = "0700";
          RuntimeDirectoryPreserve = "yes";
          StateDirectory = clientStateDirectories;
          StateDirectoryMode = "0700";
          UMask = "0077";
          Restart = "on-failure";
          RestartSec = "1s";
          TimeoutStopSec = "6s";
        };
      };

      systemd.services.nkvn-client-always-on = lib.mkIf service.alwaysOn {
        description = "Keep the selected nkvn network connected";
        unitConfig.StartLimitIntervalSec = "0";
        requires = [ "nkvn-client.service" ];
        after = [ "nkvn-client.service" ];
        partOf = [ "nkvn-client.service" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${cfg.package}/bin/nkvn-client ensure-up --wait-ms 0";
          User = "root";
          Group = "root";
          UMask = "0077";
          Restart = "on-failure";
          RestartSec = "5s";
          TimeoutStartSec = "5s";
        };
      };

      systemd.paths.nkvn-client-always-on = lib.mkIf service.alwaysOn {
        description = "Watch the nkvn managed catalog for always-on reconciliation";
        wantedBy = [ "multi-user.target" ];
        pathConfig = {
          PathChanged = "${clientStateDirectory}/catalog.v1";
          Unit = "nkvn-client-always-on.service";
        };
      };
    })
  ];
}
