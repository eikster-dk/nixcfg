{ options
, config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.suites.all;
in
{
  imports = [ ];
  options.features.suites.all = {
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
        bat.enable = true;
        direnv.enable = true;
        editorconfig.enable = true;
        fastfetch.enable = true;
        fish.enable = true;
        fzf.enable = true;
        git.enable = true;
        ghostty.enable = true;
        lazygit.enable = true;
        lsd.enable = true;
        nvim.enable = true;
        ssh.enable = true;
        starship.enable = true;
        tmux = {
          enable = true;
          sessionizer = true;
        };
        top.enable = true;
        yazi.enable = true;
        xh.enable = true;
        zoxide.enable = true;
      };
      languages = {
        golang.enable = true;
      };
    };
  };
}
