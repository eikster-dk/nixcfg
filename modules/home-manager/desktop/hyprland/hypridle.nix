{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop.hyprland.hypridle;
in
{
  options.features.desktop.hyprland.hypridle.enable = mkEnableOption "enable hypridle and additional configs";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hypridle
      brightnessctl
    ];

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock --immediate --no-fade-in";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 300;
            on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s && ${pkgs.brightnessctl}/bin/brightnessctl -s set 5";
            on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
          }
          {
            timeout = 330;
            on-timeout = "hyprlock";
          }
          {
            timeout = 360;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
