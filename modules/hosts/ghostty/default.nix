{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.ghostty;
in
{
  options.features.ghostty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        enable custom ghostty module
      '';
    };
  };
}
