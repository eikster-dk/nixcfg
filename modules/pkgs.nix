{ pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home.packages = with pkgs; [
    (pkgs.callPackage ../packages/scripts/default.nix { })
    comma
    fd
    go-task
    hurl
    jq
    karabiner-elements
    ngrok
    nodejs_20 #consider moving to nodenv?
    ripgrep
    tree
    zk
  ];
}

