{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.dysk;
in
{
  options.features.cli.dysk.enable = mkEnableOption "enable dysk mounted disk cli util";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dysk
    ];
  };
}
