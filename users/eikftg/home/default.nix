{ inputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    inputs.self.homeManagerModules.eikster
    #./dotfiles
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
  home.packages =
    [
    ];
}
