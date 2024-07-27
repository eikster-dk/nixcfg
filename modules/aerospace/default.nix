{  pkgs, config, ... }: {
  xdg.configFile."/aerospace/aerospace.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink /aerospace/aerospace.toml;
  };
}
