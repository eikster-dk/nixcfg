{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.lsd;
in
{
  options.features.cli.lsd.enable = mkEnableOption "enable lsd";

  config = mkIf cfg.enable {
    programs.lsd = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

