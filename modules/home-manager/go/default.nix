{ inputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  cfg = config.features.languages.golang;
in
{
  options.features.languages.golang.enable = mkEnableOption "enable golang language";

  config = mkIf cfg.enable {
    programs.go = {
      enable = true;
      goPath = "Developer/Go";
      goPrivate = [
        "github.com/eikster-dk"
      ];
    };
  };
}

