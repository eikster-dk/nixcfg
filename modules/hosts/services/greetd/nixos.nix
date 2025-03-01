{ options
, config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.services.greetd;
in
{
  options.features.services.greetd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable greetd as login manager with tuigreet
      '';
    };

    session = lib.mkOption {
      description = "Default command to execute on login.";
      default = "Hyprland";
      type = lib.types.str;
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      greetd = {
        enable = true;
        vt = 3;
        settings = {
          default_session = {
            command = lib.mkDefault "${lib.getExe pkgs.greetd.tuigreet} --asterisks --user-menu -g 'Welcome to NixOS ${config.system.nixos.release}' --time --remember --cmd ${cfg.session}";
          };
        };
      };
    };
  };
}
