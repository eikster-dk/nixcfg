{ pkgs, ... }: {
  imports = [
    ./aws.nix
    ./bat.nix
    ./direnv.nix
    ./editorconfig.nix
    ./fish
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./go.nix
    ./lazygit.nix
    ./neovim
    ./fastfetch.nix
    ./ssh.nix
    ./starship.nix
    ./tmux
    ./top.nix
    ./yazi.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.lsd = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    extraOptions = [ "-l" "--icons" "--git" "-a" ];
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
