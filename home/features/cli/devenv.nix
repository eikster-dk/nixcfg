{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.devenv;
in
{
  options.features.cli.devenv.enable = mkEnableOption "enable devenv";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.devenv
    ];
  };
}
