{ options
, config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.desktop.hyprland;
in
{
  options.features.desktop.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable hyprland for nixos
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      hyprlock.enable = true;
    };

    security.pam.services.hyprlock = {};

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
