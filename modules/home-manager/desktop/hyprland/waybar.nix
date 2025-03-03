{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.desktop.hyprland.waybar;
in
{
  options.features.desktop.hyprland.waybar.enable = mkEnableOption "enable waybar and additional configs";

  config = mkIf cfg.enable {
    home.packages =
      (with pkgs; [
        blueberry
        networkmanager
        networkmanager_dmenu
        pavucontrol
        rofi-power-menu
      ]);

    programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings = {
        mainbar = {
          layer = "top";
          position = "top";
          mod = "dock";
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;
          height = 0;
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [
            "bluetooth"
            "pulseaudio"
            "network"
            "backlight"
            "group/hardware"
            "clock"
          ];
          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            on-click = "activate";
            format = " {name} ";
          };
          "group/hardware" = {
            "orientation" = "inherit";
            "drawer" = {
              "transition-duration" = 300;
              "children-class" = "group-hardware";
              "transition-left-to-right" = false;
            };
            "modules" = [ "battery" "memory" "cpu" ];
          };

          cpu = {
            format = "{usage}% ";
          };
          memory = {
            format = "{}% ";
          };

          pulseaudio = {
            "format" = "{icon}  {volume}%";
            "format-bluetooth" = " {volume}% {icon} {format_source}";
            "format-bluetooth-muted" = " {icon} {format_source}";
            "format-muted" = " {format_source}";
            "format-source" = "{volume}% ";
            "format-source-muted" = "";
            "format-icons" = {
              "headphone" = " ";
              "hands-free" = " ";
              "headset" = " ";
              "phone" = " ";
              "portable" = " ";
              "car" = " ";
              "default" = [ "" "" "" ];
            };
            "on-click" = "pavucontrol -t 3";
            scroll-step = 5;
          };

          bluetooth = {
            "on-click" = "blueberry";
            "format" = "";
            "format-connected" = " {num_connections}";
            "format-disabled" = "";
            tooltip-format = "{controller_alias}	{controller_address}";

            tooltip-format-connected = ''
              {controller_alias}	{controller_address}

              {device_enumerate}'';

            tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
          };

          network = {
            "format" = "{ifname}";
            "format-wifi" = "   {signalStrength}%";
            "format-ethernet" = "  {ifname}";
            "format-disconnected" = "Disconnected";
            "tooltip-format" = " {ifname} via {gwaddri}";
            "tooltip-format-wifi" = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
            "tooltip-format-ethernet" = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
            "tooltip-format-disconnected" = "Disconnected";
            "max-length" = 50;
            "on-click" = "networkmanager_dmenu -i";
          };

          backlight = {
            "format" = "{icon} {percent}%";
            "format-icons" = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
            "scroll-step" = 1;
          };
          tray = {
            icon-size = 13;
            spacing = 10;
          };
          clock = {
            format = "{:%H:%M}";
            tooltip-format = "{:%d-%m-%Y | %H:%M}";
          };
        };
      };

      style = lib.mkAfter ''
          tooltip {
            border-radius: ${toString 10}px;
          }

          #battery,
          #bluetooth,
          #clock,
          #network,
          #pulseaudio,
          #tray {
            margin: 0px 5px;
            padding: 0px 5px;
          }

          #clock,
          #hardware,
          #workspaces {
            margin: 0px 5px;
            padding: 0px 2.5px;
          }

          #workspaces button {
            border-radius: 0px;
          }

          #workspaces button.active,
          #workspaces button.focused {
            color: ${config.lib.stylix.colors.withHashtag.base0D};
          }

          #battery.charging {
            color: ${config.lib.stylix.colors.withHashtag.base0B};
          }

          #battery.critical:not(.charging),
          #network.disabled,
          #network.disconnected,
          #pulseaudio.muted {
            color: ${config.lib.stylix.colors.withHashtag.base08};
          }

          #tray {
            margin: 0px 5px 2px 5px;
            padding: 0px 2.5px;
          }

          #waybar {
            border-radius: 0;
          }
      '';

    };
  };
}
