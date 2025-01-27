{ options
, config
, lib
, pkgs
, ...
}:
let
  cfg = config.features.localization;
in
{
  options.features.localization = {
    UTC = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = '''';
    };
    danish = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = '''';
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.danish {
      # Set your time zone.
      time.timeZone = "Europe/Copenhagen";
      # Select internationalisation properties.
      i18n.defaultLocale = "en_DK.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "da_DK.UTF-8";
        LC_IDENTIFICATION = "da_DK.UTF-8";
        LC_MEASUREMENT = "da_DK.UTF-8";
        LC_MONETARY = "da_DK.UTF-8";
        LC_NAME = "da_DK.UTF-8";
        LC_NUMERIC = "da_DK.UTF-8";
        LC_PAPER = "da_DK.UTF-8";
        LC_TELEPHONE = "da_DK.UTF-8";
        LC_TIME = "da_DK.UTF-8";
      };
    })
    (lib.mkIf cfg.UTC {
      # Set your time zone.
      time.timeZone = "UTC";
      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    })
  ];
}
