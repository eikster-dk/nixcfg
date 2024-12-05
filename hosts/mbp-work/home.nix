{ config
, pkgs
, host
, username
, options
, lib
, ...
}:
let
  inherit (import ./variables.nix);
in
{
  imports = [
    ../../home/features/cli
    ../../home/features/macos
  ];

  home.stateVersion = "24.05";
  home.username = "eikftg";
  home.homeDirectory = "/Users/eikftg";

  # theme
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  features = {
    macos = {
      aerospace.enable = true;
    };
    cli = {
      dysk.enable = true;
      fish.enable = true;
      fastfetch.enable = true;
      kitty.enable = true;
      nvim.enable = true;
      tmux.enable = true;
      wezterm.enable = true;
      zellij.enable = true;
    };
  };
}
