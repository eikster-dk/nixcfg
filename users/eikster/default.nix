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
  age.secrets.eikster.file = (inputs.self + /secrets/eikster.age);

  users.mutableUsers = false;

  users.users.eikster = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "eikster";
    hashedPasswordFile = config.age.secrets.eikster.path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      eikster = import ./home;
    };
  };
}
