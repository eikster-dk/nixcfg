{ options
, config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features.nixSettings;
in
{
  imports = [
  ];
  config = lib.mkIf cfg.enable {
    nix = {
      gc = {
        automatic = true;
        interval.Hour = 1;
        options = "--delete-older-than 7d";
      };
      #Nix Store config, hard linking identical dependancies etc.
      settings = {
        allowed-users = [
          "eikster"
          "eikftg"
        ];
      };
    };
    services.nix-daemon.enable = true;
    #At the time of making the config nix breaks when darwin documentation is enabled.
    documentation.enable = false;
  };
}
