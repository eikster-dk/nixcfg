{ pkgs, ... }: {
  imports = [
    ./aws.nix
    ./atuin.nix
    ./bat.nix
    ./devenv.nix
    ./direnv.nix
    ./dysk.nix
    ./editorconfig.nix
    ./fish
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./go.nix
    ./kitty.nix
    ./lazygit.nix
    ./lsd.nix
    ./neovim
    ./fastfetch.nix
    ./ssh.nix
    ./starship.nix
    ./tmux
    ./top.nix
    ./wezterm
    ./yazi.nix
    ./zellij.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.bat = { enable = true; };

  home.packages = with pkgs; [
    air
    comma
    dogdns
    fd
    go-task
    jq
    ngrok
    nodejs_20
    ripgrep
    rsync
    sqlc
    tailwindcss
    tree
    tldr
    ulid
    zk
  ];
}
