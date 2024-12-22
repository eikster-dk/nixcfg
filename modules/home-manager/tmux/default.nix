{ pkgs, config, lib, ... }:
with lib; let
  cfg = config.features.cli.tmux;

  ## todo: make better!
  # sessionizer = pkgs.stdenv.mkDerivation {
  #   pname = "tmux-sessionizer";
  #   version = "unstable";
  #   src = ./sessionizer;
  #   installPhase = ''
  #     mkdir -p $out/bin
  #     cp * $out/bin
  #     ln -sf $out/bin/open $out/bin/xdg-open
  #   '';
  # };
in
{
  options.features.cli.tmux.enable = mkEnableOption "enable extended tmux configuration";
  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      extraConfig = builtins.readFile ./tmux.conf;
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
      ];
    };

    home.packages = [
      # sessionizer
    ];
  };
}
