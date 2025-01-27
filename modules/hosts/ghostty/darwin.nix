{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.ghostty;
in
{
  imports = [ ];
  config = lib.mkIf cfg.enable {
    homebrew.casks = [
      "ghostty"
    ];
  };
}
