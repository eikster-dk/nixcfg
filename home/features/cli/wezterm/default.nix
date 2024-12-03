{ pkgs, config, lib, ... }:
with lib; let
  cfg = config.features.cli.wezterm;
in
{
  options.features.cli.wezterm.enable = mkEnableOption "enable extended wezterm configuration";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wezterm
    ];
    xdg.configFile."wezterm/wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink ./wezterm.lua;
    };
  };
}
