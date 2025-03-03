{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.fastfetch;
in
{
  options.features.cli.fastfetch.enable = mkEnableOption "enable fastfetch";

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          padding = {
            bottom = 3;
            top = 3;
          };
          source = "NixOs_small";
        };
        modules = [
          "break"
          "title"
          {
            key = "host  ";
            keyDolor = "33";
            type = "host";
          }
          {
            key = "os    ";
            keyDolor = "33";
            type = "os";
          }
          {
            format = "{1}d {2}h {3}m";
            key = "uptime";
            keyDolor = "33";
            type = "uptime";
          }
          {
            key = "kernel";
            keyDolor = "33";
            type = "kernel";
          }
          {
            key = "wm    ";
            keyDolor = "33";
            type = "wm";
          }
          {
            key = "cpu   ";
            keyDolor = "33";
            type = "cpu";
          }
          {
            key = "gpu   ";
            keyDolor = "33";
            type = "gpu";
          }
          {
            key = "memory";
            keyDolor = "33";
            type = "memory";
          }
          {
            key = "disk  ";
            keyDolor = "33";
            type = "disk";
          }
          {
            key = "bat";
            keyDolor = "33";
            type = "battery";
          }
        ];
      };
    };
  };
}
