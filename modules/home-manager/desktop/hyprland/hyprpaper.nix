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
    home.file = {
      "Pictures/current.jpg".source = ./backgrounds/car-with-full-moon-background.jpg;
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "/home/eikster/Pictures/current.jpg"
        ];
        wallpaper = ", /home/eikster/Pictures/current.jpg";
      };
    };
  };
}
