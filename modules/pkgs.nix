{ pkgs, ... }: {
  home.packages = with pkgs; [
   (pkgs.callPackage ../packages/scripts/default.nix { })
    go-task
    zk
    karabiner-elements
  ];
}

