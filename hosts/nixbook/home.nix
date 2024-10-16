{
  pkgs,
  lib,
  ...
}:
let
  inherit (import ./variables.nix);
in
{
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "1password-gui"
        "1password"
      ];
    };
  };

  # Home Manager Settings
  home.username = "eikster";
  home.homeDirectory = "/home/eikster";
  home.stateVersion = "24.05";

  imports = [
    ../../modules/git.nix
    ../../modules/neovim
    ../../modules/wezterm
    ../../modules/ssh.nix
  ];
}

