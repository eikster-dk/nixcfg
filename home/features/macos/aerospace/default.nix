  { config
  , lib
  , pkgs
  , ...
  }:
  with lib; let
    cfg = config.features.macos.aerospace;
  in
  {
    options.features.macos.aerospace.enable = mkEnableOption "enable aerospace";

    config = mkIf cfg.enable {
      xdg.configFile."aerospace/aerospace.toml" = {
        source = config.lib.file.mkOutOfStoreSymlink ./aerospace.toml;
      };
    };
  }
