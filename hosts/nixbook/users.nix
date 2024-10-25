{ pkgs
, ...
}:
let
  inherit (import ./variables.nix);
in
{
  security.pam.services.hyprlock = { };
  security.polkit.enable = true;

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [
        "eikster"
      ];
    };
  };

  users.users = {
    "eikster" = {
      homeMode = "755";
      isNormalUser = true;
      description = "eikster";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
      ];
      shell = pkgs.fish;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
        (pkgs.callPackage ../../packages/scripts/default.nix { })
        bruno
        discord
        kitty
        obsidian
        polypane
        slack
        spotify
      ];
    };
  };
}

