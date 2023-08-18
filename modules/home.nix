{ pkgs, ... }: {
  home.username = "eikchristensen";
  home.homeDirectory = "/Users/eikchristensen";
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
  home.sessionVariables = {
      EDITOR = "nvim";
      PROJECTS = "$HOME/code";
  };
}
