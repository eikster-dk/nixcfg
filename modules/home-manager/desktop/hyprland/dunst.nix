{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop.hyprland.dunst;
in
{
  options.features.desktop.hyprland.dunst.enable = mkEnableOption "enable dunst and additional configs";

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          frame_color = "#89b4fa";
          separator_color = "frame";
        };
        urgency_low = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        urgency_normal = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        urgency_critical = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#fab387";
        };
      };
    };
  };
}
