{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.aws;
in
{
  options.features.cli.aws.enable = mkEnableOption "enable aws";

  config = mkIf cfg.enable {
    programs.awscli = {
      enable = true;
    };
  };
}
