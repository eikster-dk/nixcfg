{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.gh;
in
{
  options.features.cli.gh.enable = mkEnableOption "enable gh";

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;
      settings = {
        version = "1";
        editor = "nvim";
        git_protocol = "ssh";
      };
    };
  };
}

