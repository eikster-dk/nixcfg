{ config
, lib
, ...
}:
with lib; let
  cfg = config.features.hyprland;
in
{
  options.features.hyprland.enable = mkEnableOption "Enable hyprland";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        monitor=,preferred,auto,1.6
      '';

      settings = {
        xwayland = {
          force_zero_scaling = true;
        };

        exec-once = [
          "waybar"
          "& blueman-applet"
        ];

        input = {
          kb_layout = "dk";
          kb_variant = "nodeadkeys";
          follow_mouse = 1;

          touchpad = {
            natural_scroll = false;
          };

          sensitivity = 0; # -1.0 to 1.0, 0 means no modification.
        };

        general = {
          border_size = 3;

          "col.active_border" = "$mauve $flamingo 90deg";
          "col.inactive_border" = "$subtext0";

          resize_on_border = true;

          gaps_in = 2;
          gaps_out = 4;

          layout = "dwindle";

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false;
        };

        decoration = {
          rounding = 4;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        animations = {
          enabled = true;
          bezier = "linear, 0.0, 0.0, 1, 1";

          animation = [
            "borderangle, 1, 50, linear, loop"
            "workspaces,1,0.5,default"
            "windows,0,0.1,default"
            "fade,0,0.1,default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = { };

        gestures = {
          workspace_swipe = false;
        };

        "$mainMod" = "SUPER";
        "$terminal" = "kitty";
        "$menu" = "wofi --show drun";
        "$fileManager" = "dolphin";

        bind = [
          "$mainMod, return, exec, kitty -e fish -c 'fastfetch; exec fish'"
          "$mainMod, space, exec, $menu"
          "$mainMod, c, killactive"
          "$SUPER_SHIFT, l, exec, hyprlock"
          "$SUPER_SHIFT, R, exec, hyprctl reload"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        windowrule = [
        ];
      };
    };
  };
}
