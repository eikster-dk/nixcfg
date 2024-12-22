{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.atuin;
in
{
  options.features.cli.atuin.enable = mkEnableOption "enable atuin";

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
