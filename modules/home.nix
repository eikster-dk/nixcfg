{ pkgs, ... }: {
  home.username = "eikster";
  home.homeDirectory = "/Users/eikster";
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
  home.sessionVariables = {
      EDITOR = "nvim";
      PROJECTS = "$HOME/code";
      SECOND_BRAIN = "/Users/eikster/Library/Mobile Documents/iCloud~md~obsidian/Documents/second brain";
  };
}
