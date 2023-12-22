{ config, ... }: {
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/config.local" ];
    serverAliveInterval = 60;
  };
}
