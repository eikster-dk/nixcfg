{ config, ... }: {
  xdg.configFile."k9s/skin.yml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./skin.yml;
  };
  programs.k9s = {
    enable = true;
  };
}

