{ inputs
, lib
, config
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.git;
in
{
  options.features.cli.git.enable = mkEnableOption "enable custom git settings";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Eik Emil Bengtsson";
      userEmail = "git.noreply@e16n.dev";
      includes = [
        {
          contents = {
            user = {
              name = "Eik Emil Bengtsson";
              email = "git.noreply@codesimplified.dk";
            };
            commit = { gpgSign = false; };
          };
          condition = "gitdir:~/code/freelance/**";
        }
      ];
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "Dracula";
        };
      };
      ignores = [
        "*~"
        ".DS_Store"
        ".idea"
        ".vscode"
        ".svn"
        ".env"
        ".envrc"
        "*.log"
        ".secrets"
      ];
      extraConfig = {
        user = {
          signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIq+zookh594RW+ltkDYWDAvyzgDtzEGdQFj3U4tvfit";
        };
        gpg.format = "ssh";
        gpg.ssh.program = (if pkgs.stdenv.isDarwin then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" else "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}");
        commit.gpgsign = true;

        pull = { ff = "only"; };
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
        lfs = { enable = true; };
        core = {
          editor = "nvim";
          compression = -1;
          autocrlf = "input";
          whitespace = "trailing-space,space-before-tab";
          precomposeunicode = true;
        };
      };
    };
  };
}
