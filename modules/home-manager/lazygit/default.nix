{ inputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.lazygit;
in
{
  options.features.cli.lazygit.enable = mkEnableOption "enable lazygit";

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
    };
  };
}

