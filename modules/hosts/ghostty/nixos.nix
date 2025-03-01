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
    environment.systemPackages = [
      inputs.ghostty.packages.x86_64-linux.default
    ];
  };
}
