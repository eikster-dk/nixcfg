{ inputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    inputs.self.homeMangerModules.eikster
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
  home.sessionVariables = {
    EDITOR = "nvim";
    PROJECTS = "$HOME/code";
  };

  home.packages = with pkgs; [
  ];

  features = {
    suites = {
      admin.enable = true;
    };
  };
}
