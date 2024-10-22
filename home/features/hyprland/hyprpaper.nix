{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.hyprland.hyprpaper;
in
{
  options.features.hyprland.hyprpaper.enable = mkEnableOption "enable hyprpaper and additional configs";

  config = mkIf cfg.enable {
    home.file = {
      "Pictures/shaded.png".source = ./backgrounds/shaded.png;
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "/home/eikster/Pictures/shaded.png"
        ];
        wallpaper = ", /home/eikster/Pictures/shaded.png";
      };
    };
  };
}
