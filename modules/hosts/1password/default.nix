{
  options,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features._1password;
in
{
  options.features._1password = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        enable custom 1password module
      '';
    };
  };
}
