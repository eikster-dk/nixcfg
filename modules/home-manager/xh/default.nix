{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.xh;
in
{
  options.features.cli.xh.enable = mkEnableOption "Enable xh, curl alternative written in rust";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xh
    ];
  };
}
