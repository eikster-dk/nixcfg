{ pkgs, ... }: {
  home.packages = with pkgs; [
    (pkgs.callPackage ../packages/scripts/default.nix { })
    comma
    fd
    go-task
    hurl
    jq
    karabiner-elements
    nodejs_20 #consider moving to nodenv?
    ripgrep
    zk
  ];
}

