{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.zellij;
in
{
  options.features.cli.zellij.enable = mkEnableOption "enable zellij";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        default_mode = "locked";
      };
    };
  };
}
