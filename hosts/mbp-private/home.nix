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
    ../../modules/aerospace
    ../../modules/fish
    ../../modules/k9s
    ../../modules/neovim
    ../../modules/wezterm/default.nix
    ../../modules/tmux
    ../../modules/home.nix
    ../../modules/aws.nix
    ../../modules/bat.nix
    ../../modules/direnv.nix
    ../../modules/editorconfig.nix
    ../../modules/fzf.nix
    ../../modules/gh.nix
    ../../modules/git.nix
    ../../modules/go.nix
    ../../modules/lazygit.nix
    ../../modules/lsd.nix
    ../../modules/pkgs.nix
    ../../modules/ssh.nix
    ../../modules/starship.nix
    ../../modules/top.nix
    ../../modules/yazi.nix
    ../../modules/yubikeys.nix
    ../../modules/zoxide.nix
  ];
}
