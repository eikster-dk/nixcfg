{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.direnv;
in
{
  options.features.cli.direnv.enable = mkEnableOption "enable direnv";

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      config = { global = { load_dotenv = true; }; };
    };
  };
}
