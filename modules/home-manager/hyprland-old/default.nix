{ pkgs, ... }: {
  imports = [
    ./dunst.nix
    ./fonts.nix
    ./gtk.nix
    ./hyprland.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprlock.nix
    ./rofi.nix
    ./waybar.nix
    ./wofi.nix
  ];
}
