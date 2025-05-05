{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop.hyprland.hyprlock;
in
{
  options.features.desktop.hyprland.hyprlock.enable = mkEnableOption "enable hyprlock and additional configs";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprlock
    ];

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          enable_fingerprint = true;
        };

        label = [
          {
            monitor = "";
            text = "$TIME";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 95;
            font_family = "JetBrains Mono";
            position = "0, 300";
            halign = "center";
            valign = "center";
          }
          {

            monitor = "";
            text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 22;
            font_family = "JetBrains Mono";
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
        ];

        # USER AVATAR
        # image = {
        #   monitor = "";
        #   path = ./backgrounds/shaded.png;
        #
        #   size = "100";
        #   position = "0, 75";
        #   halign = "center";
        #   valign = "center";
        # };

        input-field = {
          monitor = "";
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          fade_on_empty = false;
          rounding = -1;
          placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
          hide_input = false;
          position = "0, -35";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
