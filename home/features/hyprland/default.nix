{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./hyprland.nix
    ./wayland.nix
    ./wofy.nix
  ];

  home.packages = with pkgs; [
  ];
}
