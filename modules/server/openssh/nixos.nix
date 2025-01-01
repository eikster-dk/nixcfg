{ options
, config
, lib
, pkgs
, ...
}:
let
  cfg = config.features.ssh;
  inherit (config.networking) hostName;
in
{
  options.features.ssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        enable custom ssh module
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 22 ];
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = false;
        X11Forwarding = false;
        KbdInteractiveAuthentication = false;
        UseDns = false;
        StreamLocalBindUnlink = true;
      };
    };
  };
}
