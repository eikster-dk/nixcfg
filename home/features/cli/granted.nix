{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.granted;
  granted = (pkgs.callPackage ../../../packages/granted/default.nix { });
in
{
  options.features.cli.granted.enable = mkEnableOption "enable granted.dev";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
        granted
    ];

    programs.fish = {
      shellAliases = {
        assume = "source ${granted}/share/assume.fish";
      };
    };
  };
}
