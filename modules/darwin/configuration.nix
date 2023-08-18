{ pkgs, ... }: {
  services = { nix-daemon = { enable = true; }; };
  nix.package = pkgs.nix;
  nix.settings.trusted-users = [ "root" "eikchristensen" ];

  homebrew = {
      enable = true;
      casks = [
        "wezterm"
      ];
  };

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
    };
  };
}

