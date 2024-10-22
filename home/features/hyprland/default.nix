{ pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    hyprlock
    hypridle
  ];
}
