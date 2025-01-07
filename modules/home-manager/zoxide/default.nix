{ inputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.zoxide;
in
{
  options.features.cli.zoxide.enable = mkEnableOption "enable extended zoxide configuration";
  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = config.features.cli.fish.enable;
    };
  };
}
