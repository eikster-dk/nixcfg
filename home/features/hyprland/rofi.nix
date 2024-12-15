{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.hyprland.rofi;
in
{
  options.features.hyprland.rofi.enable = mkEnableOption "enable rofi and additional configs";

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
    };
  };
}
