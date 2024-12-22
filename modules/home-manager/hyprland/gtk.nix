{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.hyprland;
in
{
  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      catppuccin.enable = true;
      catppuccin.flavor = "mocha";
    };

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };
}
