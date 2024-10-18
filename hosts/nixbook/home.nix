{ pkgs
, lib
, ...
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
    ../../home/features/cli
    ../../home/features/hyprland
  ];

  features = {
    cli = {
      fish.enable = true;
     #fzf.enable = true;
      fastfetch.enable = true;
      nvim.enable = true;
      tmux.enable = true;
    };
    hyprland = { 
        enable = true;
        waybar.enable = true;
        wofi.enable = true;
        fonts.enable = true;
    };
  };
}

