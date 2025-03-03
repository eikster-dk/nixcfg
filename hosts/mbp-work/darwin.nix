{ inputs
, lib
, config
, pkgs
, ...
}:
let
  hostname = "eikster-ftg";
in
{
  imports = [
    inputs.self.darwinModules.eikster
  ];

  networking = {
    computerName = hostname;
    localHostName = hostname;
  };
  features = {
    _1password.enable = true;
    agenix.enable = true;
    ghostty.enable = true;
    karabiner.enable = true;
  };


  services = { nix-daemon = { enable = false; }; };
  nix.settings.trusted-users = [ "root" "eikftg" ];
  nix.enable = false;
  system.stateVersion = 5;
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [
      "nikitabobko/tap"
    ];
    brews = [
      "pulumi/tap/pulumi"
      "podman-compose"
    ];
    casks = [
      "arc"
      "bruno"
      "discord"
      "obsidian"
      "podman-desktop"
      "polypane"
      "raycast"
      "slack"
      "spotify"
      "tableplus"
      {
        name = "aerospace";
        greedy = true;
      }
    ];
  };

  programs.fish.shellInit = ''
    fish_add_path -a /opt/homebrew/bin/
  '';

  system = {
    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        orientation = "left";
        tilesize = 35;
        showhidden = true;
        show-recents = true;
        show-process-indicators = true;
        expose-animation-duration = 0.1;
        expose-group-by-app = true;
        launchanim = false;
        mineffect = "scale";
        mru-spaces = false;
      };
      spaces = {
        spans-displays = false;
      };
      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        AppleShowScrollBars = "Always";
        NSWindowResizeTime = 0.1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        AppleInterfaceStyle = "Dark";
        NSDocumentSaveNewDocumentsToCloud = false;
        _HIHideMenuBar = false;
        "com.apple.springing.delay" = 0.0;
      };
      finder = {
        FXPreferredViewStyle = "Nlsv";
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        AppleShowAllFiles = true;
        ShowStatusBar = true;
        ShowPathbar = true;
      };
      CustomUserPreferences = {
        "com.apple.NetworkBrowser" = { "BrowseAllInterfaces" = true; };
        "com.apple.screensaver" = {
          "askForPassword" = true;
          "askForPasswordDelay" = 0;
        };
        "com.apple.trackpad" = { "scaling" = 2; };
        "com.apple.mouse" = { "scaling" = 2.5; };
        "com.apple.desktopservices" = { "DSDontWriteNetworkStores" = false; };
        "com.apple.LaunchServices" = { "LSQuarantine" = true; };
        "com.apple.finder" = {
          "ShowExternalHardDrivesOnDesktop" = false;
          "ShowRemovableMediaOnDesktop" = false;
          "WarnOnEmptyTrash" = false;
        };
        "NSGlobalDomain" = {
          "NSNavPanelExpandedStateForSaveMode" = true;
          "NSTableViewDefaultSizeMode" = 1;
          "WebKitDeveloperExtras" = true;
        };
        "com.apple.ImageCapture" = { "disableHotPlug" = true; };
      };
    };
  };
}

