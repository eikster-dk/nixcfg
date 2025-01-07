{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.karabiner;
in
{
  options.features.karabiner = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        enable custom karabiner module
      '';
    };
  };
}
