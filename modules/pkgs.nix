{ pkgs, ... }: {
  home.packages = with pkgs; [
    scaleway-cli
    zk
  ];
}

