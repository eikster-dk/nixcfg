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
    xdg.configFile."zellij/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink ./config.kdl;
    };

    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
