{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.features.services.tailscale;
in
{
  options.features.services.tailscale = {
    enable = lib.mkEnableOption "Enable Tailscale service";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      allowedUDPPorts = [ config.services.tailscale.port ];
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
    };

    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "both";
    };
  };
}
