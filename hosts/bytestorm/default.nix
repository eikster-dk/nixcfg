{ config
, lib
, pkgs
, inputs
, modulesPath
, ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    inputs.self.nixosModules.eikster
    (inputs.self + /users/eikster)
  ];

  config = {
    system.stateVersion = "24.11";
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    environment.defaultPackages = lib.mkForce [ ];

    # Bootloader.
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
    };

    # Enable networking
    networking = {
      hostName = "bytestorm";
      hostId = "";

      networkmanager.enable = true;
    };

    features = {
      _1password.enable = true;
      nixSettings.enable = true;
      agenix.enable = true;
      primaryUsers.users = [ "eikster" ];
    };
  };
}
