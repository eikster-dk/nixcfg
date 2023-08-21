{ pkgs, ... }: {
  programs.direnv = {
    enable = true;
    config = { global = { load_dotenv = true; }; };
  };
}
