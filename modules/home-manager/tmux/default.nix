{ pkgs, config, lib, ... }:
with lib; let
  cfg = config.features.cli.tmux;
in
{
  options.features.cli.tmux.enable = mkEnableOption "enable extended tmux configuration";
  options.features.cli.tmux.sessionizer = mkEnableOption "enable custom sessionzer";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      extraConfig = builtins.readFile ./tmux.conf;
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
      ];
    };

    home.packages = with pkgs; [
    ]
    ++ (lib.optionals (cfg.sessionizer) [
      (pkgs.callPackage ../../scripts/sessionizer/default.nix { })
    ]);
  };
}
