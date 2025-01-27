{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}:
let
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  features.ssh.enable = true;
  users.mutableUsers = false;
  users.users.admin = {
    isNormalUser = true;
    description = "admin";
    hashedPassword = null;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHo5dY2ZByhzqZpTzARo67k5Fxzf97h+ixR/lBv2wZv/"
    ];
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Enable admin account to use ssh without password (since the admin account doesn't HAVE a password)
  security.sudo.extraRules = [
    {
      users = [ "admin" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      # Import your home-manager configuration
      admin = import ./home;
    };
  };
}
