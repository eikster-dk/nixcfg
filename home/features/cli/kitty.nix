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
        name = "JetBrainsMono Nerd Font";
        size = 14;
        package = pkgs.nerdfonts;
      };
      theme = "Catppuccin-Mocha";
      shellIntegration.enableFishIntegration = true;
      settings = {
        disable_ligatures = "never";
        background_opacity = "0.9";
      };
    };
  };
}
