{ pkgs, ... }: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_22;
    goPath = "Developer/Go";
    goPrivate = [
      "github.com/eikster-dk"
    ];
  };
}
