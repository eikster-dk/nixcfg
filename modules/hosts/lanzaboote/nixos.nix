{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.boot.secureBoot;
in
{

  options.features.boot.secureBoot = {
    enable = lib.mkEnableOption "Enable secure boot with lanzaboote";
  };

  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  config = lib.mkIf cfg.enable {

    environment.systemPackages = [
      pkgs.sbctl
    ];

    boot = {
      # initrd.systemd.enable = true;
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        configurationLimit = 10;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
