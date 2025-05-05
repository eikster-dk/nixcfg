{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.programs.pam.clamshell;

  pamGateScript = pkgs.writeShellScript "should-use-fingerprint.sh" ''
    ${pkgs.gnugrep}/bin/grep -q closed /proc/acpi/button/lid/LID0/state && exit 1
    true
  '';
in
{
  options.features.programs.pam.clamshell = {
    enable = lib.mkEnableOption "this feature will handle fingerprint authentication in clamshell mode with additional PAM settings";
  };

  config = lib.mkIf cfg.enable
    {
      security.pam.services =
        let
          serviceCfg = service: {
            rules.auth = {
              clamshell = {
                order = 100; # ensure it runs early
                control = "[success=ignore default=1]";
                modulePath = "${pkgs.linux-pam}/lib/security/pam_exec.so";
                args = [ "quiet" "${pamGateScript}" ];
              };
            };
          };
        in
        lib.flip lib.genAttrs serviceCfg [
          "sudo"
          "polkit-1"
          "hyprlock"
          "login"
        ];
    };
}
