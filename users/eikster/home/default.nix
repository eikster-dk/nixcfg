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
  home.stateVersion = "23.11";
  home.username = "eikster";
  home.homeDirectory = "/Users/eikster";
  home.sessionVariables = {
    EDITOR = "nvim";
    PROJECTS = "$HOME/code";
  };

  home.packages =
    with pkgs; [
      ### nixos + darwin packages
      air
      comma
      dogdns
      fd
      go-task
      #ngrok
      nodejs_20
      ripgrep
      rsync
      sqlc
      tailwindcss
      tree
      ulid
      zk
    ]
    ### darwin specific packages
    ++ (lib.optionals (pkgs.system == "aarch64-darwin") [
      ## todo, improve this
      (pkgs.callPackage ../../../packages/scripts/default.nix { })
      karabiner-elements
    ])
    ### nixos specific packages
    ++ (lib.optionals (pkgs.system != "aarch64-darwin") [
    ]);

  features = {
    suites = {
      all.enable = true;
    };
    macos = {
      aerospace.enable = true;
    };
  };
}
