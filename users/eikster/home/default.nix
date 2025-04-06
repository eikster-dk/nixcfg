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
      enable = true;
      hyprland = {
        enable = true;
        laptopMonitor = "desc:BOE NE135A1M-NY1,preferred,auto,1.6";
        monitors = [
          "desc:Apple Computer Inc StudioDisplay 0x4E3FCE22 (DP-5),5120x2880@60,auto,1.6"
          "desc:Apple Computer Inc StudioDisplay 0x4E3FCE22 (DP-6),disable"
        ];
        hyprlock.enable = true;
        hypridle.enable = true;
        hyprpaper.enable = true;
        mako.enable = true;
        rofi.enable = true;
        waybar.enable = true;
      };
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
  ]
  ### nixos specific packages
  ++ (lib.optionals (isLinux) [
      ./firefox
      ./hyprland
  ]);

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
  home.username = "eikster";
  home.homeDirectory = if isDarwin then "/Users/eikster" else "/home/eikster";
  home.sessionVariables = {
    EDITOR = "nvim";
    PROJECTS = "$HOME/code";
  };

  programs.nushell.enable = true;

  home.packages =
    with pkgs; [
      ### nixos + darwin packages
      air
      comma
      dogdns
      nerdfonts
      fd
      go-task
      nodejs_22
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
      obsidian
      spotify
      vesktop
    ]);

  features = commonFeatures // linuxFeatures // darwinFeatures;
}
