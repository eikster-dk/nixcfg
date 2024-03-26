{ config, lib, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  ## makes it possible to make changes to the config file and have them hot reloaded. Even tho this is not ideal, it's better than nothing.
  ## To make a "writable" symlink an absolute path is required when working from a flake
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/personal/dotfiles/modules/neovim/config";
  };
}
