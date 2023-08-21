{ ... }: {
  programs.git = {
    enable = true;
    userName = "Eik Emil Bengtsson";
    userEmail = "git.noreply@eikc.dk";
    signing = {
      key = "5C4F759C5D02EC13B5665A287ECE01F9636DCAA5";
      signByDefault = true;
    };
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
