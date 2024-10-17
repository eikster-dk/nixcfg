{ ... }: {
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = {
    };
  };

  programs.fish.interactiveShellInit = "
    function starship_transient_prompt_func
      echo
      starship module character
    end
  ";
}
