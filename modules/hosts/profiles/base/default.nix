{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.profiles.base;
in
{
  options.features.profiles.base = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Common configurations settings
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;
    security.rtkit.enable = true;
    environment.systemPackages = [
      pkgs.hyprpolkitagent
    ];
  };
}
