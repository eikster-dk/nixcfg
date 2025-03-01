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
    programs.waybar = {
      enable = true;
      style = ''
        @define-color rosewater #f5e0dc;
        @define-color flamingo #f2cdcd;
        @define-color pink #f5c2e7;
        @define-color mauve #cba6f7;
        @define-color red #f38ba8;
        @define-color maroon #eba0ac;
        @define-color peach #fab387;
        @define-color yellow #f9e2af;
        @define-color green #a6e3a1;
        @define-color teal #94e2d5;
        @define-color sky #89dceb;
        @define-color sapphire #74c7ec;
        @define-color blue #89b4fa;
        @define-color lavender #b4befe;
        @define-color text #cdd6f4;
        @define-color subtext1 #bac2de;
        @define-color subtext0 #a6adc8;
        @define-color overlay2 #9399b2;
        @define-color overlay1 #7f849c;
        @define-color overlay0 #6c7086;
        @define-color surface2 #585b70;
        @define-color surface1 #45475a;
        @define-color surface0 #313244;
        @define-color base #1e1e2e;
        @define-color mantle #181825;
        @define-color crust #11111b;

        * {
          font-family: "JetBrains Mono", monospace;
          font-size: 17px;
          min-height: 0;
        }

        #waybar {
          background: transparent;
          color: @text;
          margin: 5px 5px;
        }

        #workspaces {
          border-radius: 1rem;
          margin: 5px;
          background-color: @surface0;
          margin-left: 1rem;
        }

        #workspaces button {
          color: @lavender;
          border-radius: 1rem;
          padding: 0.4rem;
        }

        #workspaces button.active {
          color: @sky;
          border-radius: 1rem;
        }

        #workspaces button:hover {
          color: @sapphire;
          border-radius: 1rem;
        }

        #bluetooth,
        #backlight,
        #clock,
        #battery,
        #network,
        #cpu,
        #memory,
        #group-hardware,
        #pulseaudio {
          background-color: @surface0;
          padding: 0.5rem 1rem;
          margin: 5px 0;
        }

        #clock {
          color: @blue;
          border-radius: 0px 1rem 1rem 0px;
          margin-right: 1rem;
        }

        #battery {
          color: @green;
        }

        #battery.charging {
          color: @green;
        }

        #battery.warning:not(.charging) {
          color: @red;
        }

        #backlight {
          color: @yellow;
        }

        #backlight, #battery {
            border-radius: 0;
        }

        #pulseaudio {
          color: @maroon;
          border-radius: 1rem 0px 0px 1rem;
          margin-left: 1rem;
        }

        #custom-music {
          color: @mauve;
          border-radius: 1rem;
        }

        #custom-lock {
            border-radius: 1rem 0px 0px 1rem;
            color: @lavender;
        }

        #custom-power {
            margin-right: 1rem;
            border-radius: 0px 1rem 1rem 0px;
            color: @red;
        }

        #tray {
          margin-right: 1rem;
          border-radius: 1rem;
        }

      '';
      settings = {
        mainbar = {
          layer = "top";
          position = "top";
          mod = "dock";
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;
          height = 0;
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "pulseaudio"
            "network"
            "bluetooth"
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
          "pulseaudio" = {
            # "scroll-step" = 1, // %, can be a float
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
            "on-click" = "kitty --class floating -e pulsemixer";
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
            "on-click" = "kitty --class floating -e nmtui";
            "on-click-right" = "nm-applet --indicator";
          };
          "bluetooth" = {
            "format" = " {status}";
            "format-disabled" = "";
            "format-off" = "";
            "interval" = 30;
            "on-click" = "blueman-manager";
            "format-no-controller" = "";
          };
          "backlight" = {
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
            format = " {:%R   %d/%m}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };
        };
      };
    };
  };
}
