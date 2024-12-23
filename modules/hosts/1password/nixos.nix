{ config
, lib
, pkgs
, inputs
, ...
}:
let
  cfg = config.features._1password;
in
{
  imports = [ ];
  config = lib.mkIf cfg.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = config.features.primaryUser.users;
    };
  };
}
