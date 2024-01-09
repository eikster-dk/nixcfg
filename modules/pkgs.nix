{ pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home.packages = with pkgs; [
    (pkgs.callPackage ../packages/scripts/default.nix { })
    air
    comma
    (with dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0
      sdk_8_0
    ])
    fd
    go-task
    hurl
    jq
    karabiner-elements
    ngrok
    nodejs_20 #consider moving to nodenv?
    ripgrep
    sqlc
    tailwindcss
    tree
    ulid
    zk
  ];
}

