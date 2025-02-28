{ inputs
, lib
, config
, pkgs
, ...
}:
let
  isLinux = pkgs.system != "aarch64-darwin";
  isDarwin = pkgs.system == "aarch64-darwin";

  # Features common to all platforms
  commonFeatures = {
    cli = {
      granted.enable = true;
    };
    suites = {
      all.enable = true;
    };
  };

  # Linux-specific features
  linuxFeatures = lib.optionalAttrs isLinux {
    desktop = {
      hyprland = true;
    };
  };

  # macOS-specific features
  darwinFeatures = lib.optionalAttrs isDarwin {
    macos = {
      aerospace.enable = true;
    };
  };
in
{
  imports = [
    inputs.self.homeMangerModules.eikster
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
  home.username = "eikster";
  home.homeDirectory = if isDarwin then "/Users/eikster" else "/home/eikster";
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
      nodejs_20
      ripgrep
      rsync
      sqlc
      tailwindcss
      ulid
    ]
    ### darwin specific packages
    ++ (lib.optionals (isDarwin) [
      ## todo, improve this
      (pkgs.callPackage ../../../packages/scripts/default.nix { })
      karabiner-elements
    ])
    ### nixos specific packages
    ++ (lib.optionals (isLinux) [
    ]);

  features = commonFeatures // linuxFeatures // darwinFeatures;
}
