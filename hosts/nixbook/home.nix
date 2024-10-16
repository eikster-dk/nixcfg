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
    ../../modules/fish
    ../../modules/fzf.nix
    ../../modules/git.nix
    ../../modules/go.nix
    ../../modules/hyprland
    ../../modules/lazygit.nix
    ../../modules/lsd.nix
    ../../modules/neovim
    ../../modules/starship.nix
    ../../modules/wezterm
    ../../modules/ssh.nix
    ../../modules/tmux
    ../../modules/zoxide.nix
  ];

  home.packages = with pkgs; [
    (pkgs.callPackage ../../packages/scripts/default.nix { })
    air
    comma
    dogdns
    fd
    go-task
    jq
    lazydocker
    ngrok
    nodejs_20
    ripgrep
    rsync
    sqlc
    tailwindcss
    tree
    ulid
    zk
  ];

}

