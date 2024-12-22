{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.bat;
in
{
  options.features.cli.bat.enable = mkEnableOption "enable bat";

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };
  };
}
