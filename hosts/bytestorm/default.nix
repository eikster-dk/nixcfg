{ config
, lib
, pkgs
, inputs
, modulesPath
, ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    inputs.self.nixosModules.eikster
    (inputs.self + /users/eikster)
    ./stylix.nix
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
      hostId = "007f0200";

      networkmanager.enable = true;
    };

    console.keyMap = "dk-latin1";

    features = {
      _1password.enable = true;
      ghostty.enable = true;
      nixSettings.enable = true;
      agenix.enable = true;
      boot = {
        secureBoot.enable = true;
      };
      desktop = {
        enable = true;
        hyprland.enable = true;
      };
      localization = {
        danish = true;
      };
      profiles = {
        base.enable = true;
      };
      programs = {
        fwupd = {
          enable = true;
          autoCheck.enable = true;
        };
      };
      services = {
        greetd.enable = true;
      };
      primaryUsers.users = [ "eikster" ];
    };
  };
}
