{ config
, lib
, pkgs
, inputs
, modulesPath
, ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    inputs.self.nixosModules.eikster
    (inputs.self + /users/admin)
    ./disks.nix
  ];

  config = {
    networking.hostName = "mibzy";
    networking.hostId = "d42834c6";
    system.stateVersion = "24.11";

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    environment.defaultPackages = lib.mkForce [ ];

    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "sd_mod"
      "nvme"
    ];
    boot.initrd.kernelModules = [ ];
    boot.extraModulePackages = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };

    networking.useNetworkd = true;
    networking.useDHCP = false;
    networking.usePredictableInterfaceNames = false;

    systemd.network.networks."10-uplink" = {
      matchConfig.Name = lib.mkDefault "en* eth0";
      networkConfig.DHCP = "ipv4";
      networkConfig.Gateway = "fe80::1";
      networkConfig.IPv6AcceptRA = "no";
    };

    age.secrets.tailscale_auth_key.file = ../../secrets/mibzy_tailscale.age;

    features = {
      nixSettings.enable = true;
      agenix.enable = true;
      primaryUsers.users = [ "admin" ];
      ssh.enable = true;
      tailscale = {
        enable = true;
        auth_key_path = config.age.secrets.tailscale_auth_key.path;
      };
      localization.UTC = true;
    };
  };
}
