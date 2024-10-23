{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.kitty;
in
{
  options.features.cli.kitty.enable = mkEnableOption "enable kitty terminal";

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrains Mono";
        size = 14;
        package = pkgs.jetbrains-mono;
      };
      theme = "Catppuccin-Mocha";
      shellIntegration.enableFishIntegration = true;
      settings = {
        background_opacity = 0.9;
      };
    };
  };
}
