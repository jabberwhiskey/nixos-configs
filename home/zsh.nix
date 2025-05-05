{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      "ll" = "ls -l";
      "la" = "ls -la";
      "g" = "git";
    };
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

    initContent = ''
      setopt NO_NOMATCH
    '';
  };
  programs.bash.initExtra = "exec zsh";
}
