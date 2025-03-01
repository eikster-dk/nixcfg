{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop;
in
{
  options.features.desktop = {
    enable = lib.mkEnableOption "common features for desktop environments";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
    ];


    dconf = {
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
  };
}
