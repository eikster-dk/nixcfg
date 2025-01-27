{ stdenv, ... }:
stdenv.mkDerivation {
  name = "tmux-sessionizer";
  version = "unstable";
  src = ./bin;
  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
  '';
}
