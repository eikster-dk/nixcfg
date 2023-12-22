{ pkgs, ... }: {
  home.packages = with pkgs; [
    go-task
    zk
    karabiner-elements
  ];
}

