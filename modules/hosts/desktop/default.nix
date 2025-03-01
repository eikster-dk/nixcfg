{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.desktop;
in
{
  options.features.desktop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable common desktop features in nixOS
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;
    security.rtkit.enable = true;

    services = {
      blueman = {
        enable = true;
      };
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
      };
    };

    hardware = {
      pulseaudio.enable = false;
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };
  };
}
