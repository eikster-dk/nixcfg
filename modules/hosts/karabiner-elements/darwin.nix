{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.karabiner;
in
{
  imports = [ ];
  config = lib.mkIf cfg.enable {
    homebrew.casks = [
      "karabiner-elements"
    ];
  };
}
