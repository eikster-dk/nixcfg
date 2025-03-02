{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop.hyprland.hyprpaper;
in
{
  options.features.desktop.hyprland.hyprpaper.enable = mkEnableOption "enable hyprpaper and additional configs";

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
      };
    };
  };
}
