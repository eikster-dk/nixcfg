{ options
, config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.suites.admin;
in
{
  imports = [ ];
  options.features.suites.admin = {
    enable =
      lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          enable cli suite
        '';
      };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ ];
    features = {
      cli = {
        atuin.enable = true;
        fish.enable = true;
        fzf.enable = true;
        lsd.enable = true;
        nvim.enable = true;
        tmux.enable = true;
        top.enable = true;
        yazi.enable = true;
        xh.enable = true;
      };
    };
  };
}
