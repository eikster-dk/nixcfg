{
  pkgs,
  ...
}:
let
  inherit (import ./variables.nix);
in
{
  users.users = {
    "eikster" = {
      homeMode = "755";
      isNormalUser = true;
      description = "Eik Bengtsson";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
      ];
      shell = pkgs.bash;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
        _1password-gui
      	_1password
      ];
    };
  };
}

