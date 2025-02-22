{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history.expireDuplicatesFirst = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    antidote = {
      enable = true;
      plugins = [
        "lonr/ghoti"
        "marlonrichert/zsh-autocomplete"
        "agnoster/agnoster-zsh-theme" #seems to be gone?
        "davidde/git"
      ];
    };

    initExtra = ''
      setopt NO_NOMATCH
    '';
  };
  programs.bash.initExtra = "exec zsh";
}
