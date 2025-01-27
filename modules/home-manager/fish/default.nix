{ config
, pkgs
, lib
, ...
}:
with lib; let
  cfg = config.features.cli.fish;
in
{
  options.features.cli.fish.enable = mkEnableOption "enable extended fish configuration";
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellInit = builtins.readFile ./init.fish;
      plugins = [
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair-fish.src;
        }
      ];
      shellAliases = {
        # git
        g = "git";
        gl = "git pull --prune";
        glg = "git log --graph --decorate --oneline --abbrev-commit";
        glga = "glg --all";
        gp = "git push origin HEAD";
        gpa = "git push origin --all";
        gd = "git diff";
        gc = "git commit -s";
        gca = "git commit -sa";
        gco = "git checkout";
        gb = "git branch -v";
        ga = "git add";
        gaa = "git add -A";
        gcm = "git commit -sm";
        gcam = "git commit -sam";
        gs = "git status -sb";
        glnext = "git log --oneline (git describe --tags --abbrev=0 @^)..@";
        gw = "git switch";
        gm = "git switch (git main-branch)";
        gms = "git switch (git main-branch); and git sync";
        egms = "e; git switch (git main-branch); and git sync";
        gwc = "git switch -c";

        # worktree related
        gwr = "git worktree remove";
        gwa = "git worktree add";
        gwls = "git worktree list";
        gui = "lazygit";

        #ls
        lsa = "lsd -al --header";

        # go
        gmt = "go mod tidy";
        grm = "go run ./...";

        # neovim
        e = "nvim";
        v = "nvim";

        # tmux
        ta = "tmux-new";
      };
    };
  };
}
