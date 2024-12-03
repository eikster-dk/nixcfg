{ pkgs, ... }: {
  imports = [
    ./dunst.nix
    ./fonts.nix
    ./gtk.nix
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
