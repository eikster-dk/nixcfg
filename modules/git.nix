{ ... }: {
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
    ];
    extraConfig = {
      user = {
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIq+zookh594RW+ltkDYWDAvyzgDtzEGdQFj3U4tvfit";
      };
      gpg.format = "ssh";
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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
}
