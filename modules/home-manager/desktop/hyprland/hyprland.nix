{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in
{
  options.features.desktop.hyprland = {
    enable = lib.mkEnableOption "hyprland desktop environment";

    laptopMonitor = lib.mkOption {
      description = "Internal laptop monitor";
      default = null;
      type = lib.types.nullOr lib.types.str;
    };

    monitors = lib.mkOption {
      description = "List of external monitors";
      default = [ ];
      type = lib.types.listOf lib.types.str;
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        variables = [ "--all" ];
      };

      settings = import ./settings.nix { inherit config lib pkgs; };
    };

    xdg.portal = {
      enable = true;
      configPackages = [ pkgs.xdg-desktop-portal-hyprland ];

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };

    systemd.user.services.hyprpolkitagent = {
      Unit = {
        After = "graphical-session.target";
        BindsTo = [ "hyprland-session.target" ];
        Description = "PolicyKit authentication agent";
        PartOf = "graphical-session.target";
      };
      Service = {
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "no";
      };
      Install.WantedBy = [ "hyprland-session.target" ];

    };

    #   dconf.settings = {
    #     "org/gnome/desktop/vm/preferences".button-layout = "";
    #     # "org/gnome/desktop/interface" = {
    #     #   color-scheme = "prefer-dark";
    #     # };
    #   };
  };
}
