{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
  ];
}
