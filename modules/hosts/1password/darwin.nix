{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features._1password;
in
{
  imports = [ ];
  config = lib.mkIf cfg.enable {
    homebrew.casks = [
      "1password"
      "1password-cli"
    ];
  };
}
