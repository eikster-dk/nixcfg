{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.hyprland.hypridle;
in
{
  options.features.hyprland.hypridle.enable = mkEnableOption "enable hypridle and additional configs";

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "hyprlock";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "brightnessctl -s && brightnessctl -s set 5";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 330;
            on-timeout = "hyprlock";
          }
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "suspend";
          }
        ];
      };
    };
  };
}
