{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.editorconfig;
in
{
  options.features.cli.editorconfig.enable = mkEnableOption "enable editorconfig";

  config = mkIf cfg.enable {
    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          charset = "utf-8";
          end_of_line = "lf";
          trim_trailing_whitespace = true;
          insert_final_newline = true;
          max_line_width = 78;
          indent_style = "space";
          indent_size = 2;
        };
        "*.go" = {
          indent_style = "tab";
          indent_size = 4;
        };
        "Makefile" = {
          indent_style = "tab";
          indent_size = 4;
        };
      };
    };
  };
}
