{ config, ... }:
{
  programs.wofi = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  xdg.configFile."hypr/hyprland.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink ./hyprland.conf;
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}

