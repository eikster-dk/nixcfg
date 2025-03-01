{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.features;

  windowManagerBinds = {
    Down = "down";
    Left = "left";
    Right = "right";
    Up = "up";
    H = "left";
    J = "down";
    K = "up";
    L = "right";
  };
in
{
  monitor =
    [ ",preferred,auto,1.6" ];

  xwayland = {
    force_zero_scaling = true;
  };

  exec-once = [
    "waybar"
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

  misc = {
    disable_hyprland_logo = true;
    force_default_wallpaper = false;
  };


  decoration = {
    rounding = 4;
    blur = {
      enabled = true;
      size = 3;
      passes = 1;
    };
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

  windowrulev2 = [
    "suppressevent maximize, class:.*"
  ];

  layerrule = [
    "noanim, wofi"
  ];

  "$mainMod" = "SUPER";
  "$terminal" = "ghostty";
  "$menu" = "rofi -show drun";
  "$fileManager" = "dolphin";

  bind =
    [
      "$mainMod, q, exit"
      "$mainMod, return, exec, $terminal"
      "$mainMod, space, exec, $menu"
      "$mainMod, c, killactive"
      "$SUPER_SHIFT, l, exec, hyprlock"
      "$SUPER_SHIFT, R, exec, hyprctl reload"
    ]
    ++ builtins.map (x: "$mainMod SHIFT,${toString x},movetoworkspace,${toString x}") [ 1 2 3 4 5 6 7 8 9 ]
    ++ builtins.map (x: "$mainMod,${toString x},workspace,${toString x}") [ 1 2 3 4 5 6 7 8 9 ]
    ++ lib.attrsets.mapAttrsToList (key: direction: "$mainMod CTRL SHIFT,${key},movecurrentworkspacetomonitor,${builtins.substring 0 1 direction}") windowManagerBinds
    ++ lib.attrsets.mapAttrsToList (key: direction: "$mainMod SHIFT,${key},movewindow,${builtins.substring 0 1 direction}") windowManagerBinds
    ++ lib.attrsets.mapAttrsToList (key: direction: "$mainMod,${key},movefocus,${builtins.substring 0 1 direction}") windowManagerBinds;

  bindm = [
    # Move/resize windows with mainMod + LMB/RMB and dragging
    "$mainMod,mouse:272,movewindow"
    "$mainMod,mouse:273,resizewindow"
  ];

  bindl = [
  ];

  bindle = [
  ];
}
