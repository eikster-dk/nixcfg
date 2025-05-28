{ stdenv, ... }:
stdenv.mkDerivation {
  name = "scripts-bins";
  version = "unstable";
  src = ./bin;
  installPhase = ''
    mkdir -p $out/bin
    cp * $out/bin
  '';
}
