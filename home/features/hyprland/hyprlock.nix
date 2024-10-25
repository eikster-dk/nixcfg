{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.hyprland.hyprlock;
in
{
  options.features.hyprland.hyprlock.enable = mkEnableOption "enable hyprlock and additional configs";

  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          enable_fingerprint = true;
        };

        background = [
          {
            moitor = "";
            path = "/home/eikster/Pictures/current.jpg";

            blur_passes = 1; # 0 disables blurring
            blur_size = 7;
            noise = 1.17e-2;
          }
        ];

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
          size = "300,60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = "rgb(111, 45, 104)";
          fade_on_empty = false;
          rounding = -1;
          check_color = "rgb(30, 107, 204)";
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
