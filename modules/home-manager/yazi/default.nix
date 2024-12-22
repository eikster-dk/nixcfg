{ inputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.yazi;
in
{
  options.features.cli.yazi.enable = mkEnableOption "enable extended yazi configuration";
  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
    };
  };
}
