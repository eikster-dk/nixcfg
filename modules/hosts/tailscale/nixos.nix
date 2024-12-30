{ options
, config
, lib
, pkgs
, inputs
, ...
}:
with lib;
let
  cfg = config.features.tailscale;
in
{
  options.features.tailscale = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Tailscale VPN for ops stuff";
    };

    auth_key_path = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      description = ''
        allow you to specify a key, or set null to disable
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.tailscale ];
    services.tailscale.enable = true;
    systemd.services.tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";

      # make sure tailscale is running before trying to connect to tailscale
      after = [ "network-pre.target" "tailscale.service" ];
      wants = [ "network-pre.target" "tailscale.service" ];
      wantedBy = [ "multi-user.target" ];
      # set this service as a oneshot job
      serviceConfig.Type = "oneshot";

      # have the job run this shell script
      script = with pkgs; ''
        # wait for tailscaled to settle
        sleep 2

        # check if we are already authenticated to tailscale
        status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
        if [ $status = "Running" ]; then # if so, then do nothing
          exit 0
        fi

        # otherwise authenticate with tailscale
        ${tailscale}/bin/tailscale up -authkey $(cat ${cfg.auth_key_path})
      '';
    };
  };
}

