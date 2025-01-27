{ inputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.ghostty;
in
{
  options.features.cli.ghostty.enable = mkEnableOption "enable ghostty";

  config = mkIf cfg.enable {
    xdg.configFile."ghostty/config" = {
      source = config.lib.file.mkOutOfStoreSymlink ./config;
    };
  };
}
