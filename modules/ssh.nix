{ pkgs, ... }:
let
  onePassPath = (if pkgs.stdenv.isDarwin then "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" else "~/.1password/agent.sock");
in
{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 60;
    extraConfig = ''
    Host *
          IdentityAgent ${onePassPath}
    '';
  };
}
