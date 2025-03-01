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
  #age.secrets.eikster.file = (inputs.self + /secrets/eikster.age);

  users.mutableUsers = false;

  users.users.eikster = {
    isNormalUser = true;
    description = "eikster";
    password = "123456"; ## Yes this is intentional for now, and no I'm not an idiot, this will result in a age protected password
    #hashedPasswordFile = config.age.secrets.eikster.path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs;
    };
    users = {
      eikster = import ./home;
    };
  };
}
