{
  pkgs,
  ...
}:
let
  inherit (import ./variables.nix);
in
{
  # Home Manager Settings
  home.username = "eikster";
  home.homeDirectory = "/home/eikster";
  home.stateVersion = "24.05";
}

