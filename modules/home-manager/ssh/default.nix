{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.features.cli.ssh;
  onePassPath = (if pkgs.stdenv.isDarwin then "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" else "~/.1password/agent.sock");
in
{
  options.features.cli.ssh.enable = mkEnableOption "enable ssh";

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      serverAliveInterval = 60;
      extraConfig = ''
        Host *
          IdentityAgent "${onePassPath}"
        Host mibzy
          IdentityFile ~/.ssh/hetzner.pub
          IdentitiesOnly yes
      '';
    };
  };
}


