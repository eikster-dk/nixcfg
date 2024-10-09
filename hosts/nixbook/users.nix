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
      description = "eikster user";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
      ];
      shell = pkgs.bash;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [];
    };
  };
}

