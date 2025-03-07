{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.boot.secureBoot;
  cryptenroll = pkgs.writeShellScriptBin "cryptenroll" ''
    #!/bin/sh
    systemd-cryptenroll --tpm2-device=auto \
      --tpm2-pcrs=0+2+7+12+15:sha256=0000000000000000000000000000000000000000000000000000000000000000 \
      --wipe-slot=tpm2 $1
  '';

in
{
  options.features.boot.secureBoot = {
    enable = lib.mkEnableOption "Enable secure boot with lanzaboote";
  };

  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  config = lib.mkIf cfg.enable {

    environment.systemPackages = [
      cryptenroll
      pkgs.sbctl
    ];

    boot = {
      initrd.systemd.enable = true;
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        configurationLimit = 10;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
