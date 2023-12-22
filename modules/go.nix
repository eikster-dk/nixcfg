{ pkgs, ... }: {
  programs.go = {
    enable = true;
    package = pkgs.go;
    goPath = "Developer/Go";
    goPrivate = [
      "github.com/eikster-dk"
    ];
  };
}
