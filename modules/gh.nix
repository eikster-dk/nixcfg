{ ... }: {
  programs.gh = {
    enable = true;
    settings = {
        editor = "nvim";
        git_protocol = "ssh";
        extensions = [
          "eikster-dk/gh-worktree"
        ];
    };
  };
}
