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
        autohide = false;
      };
    };
  };
}

