{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.programs.fwupd;
in
{
  options.features.programs.fwupd = {
    enable = lib.mkEnableOption "Enable custom fwupd module";

    autoCheck = {
      enable = lib.mkEnableOption "Enable automatic firmware update checks and notifications";

      interval = lib.mkOption {
        type = lib.types.str;
        default = "daily";
        description = "Systemd timer interval for update checks (e.g., 'daily', 'hourly', 'weekly')";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.fwupd.enable = true;

    systemd.services.fwupd-check = lib.mkIf cfg.autoCheck.enable {
      description = "Check for firmware updates and notify the user";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "fwupd-check" ''
          #!/bin/sh
          updates=$(${pkgs.fwupd}/bin/fwupdmgr get-updates | grep -c "New version")
          if [ "$updates" -gt 0 ]; then
            ${pkgs.libnotify}/bin/notify-send "Firmware Update Available" "Run 'fwupdmgr update' to install."
          fi
        '';
      };
    };

    systemd.timers.fwupd-check = lib.mkIf cfg.autoCheck.enable {
      description = "Timer for fwupd-check service";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = cfg.autoCheck.interval;
        Persistent = true;
      };
    };
  };
}
