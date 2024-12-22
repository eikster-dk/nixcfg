{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.starship;
in
{
  options.features.cli.starship.enable = mkEnableOption "enable starship";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableTransience = true;
      settings = { };
    };

    programs.fish.interactiveShellInit = "
    function starship_transient_prompt_func
      echo
      starship module character
    end
  ";
  };
}


