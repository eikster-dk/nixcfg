{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.hyprland.fonts;
in
{
  options.features.hyprland.fonts.enable =
    mkEnableOption "install additional fonts for hyprland apps";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      jetbrains-mono
      nerdfonts
      font-awesome
    ];
  };
}
