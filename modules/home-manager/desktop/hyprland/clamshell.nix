{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.features;
  hyprctl = lib.getExe' config.wayland.windowManager.hyprland.package "hyprctl";
in {
  clamshell = pkgs.writeShellScript "hyprland-clamshell" ''
    NUM_MONITORS=$(${hyprctl} monitors all | grep Monitor | wc --lines)
    EDP_STATUS=$(${hyprctl} monitors all | grep -A 17 "Monitor eDP-1" | grep "disabled:")

    if [ "$1" == "on" ]; then
      if [ $NUM_MONITORS -gt 1 ]; then
        ${hyprctl} keyword monitor "eDP-1, disable"
      fi
    elif [ "$1" == "off" ]; then
      # Check if the monitor is disabled
      if echo "$EDP_STATUS" | grep -q "disabled: true"; then
        ${hyprctl} keyword monitor "${cfg.desktop.hyprland.laptopMonitor}"
      fi
    fi
  '';
}
