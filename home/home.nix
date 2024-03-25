{ config, pkgs, ... }:

{
  home = {
    username = "jcw";
    homeDirectory = "/home/jcw";
    packages = with pkgs; [
      btop
      mpv
      htop
      bitwarden
      bitwarden-cli
      firefox
      vivaldi
      unzip
      yt-dlp
      ffmpeg
      qutebrowser
    ];
    sessionVariables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
  };
  programs.bash = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "jcw";
    userEmail = "jwillbanks2@gmail.com";
  };
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
        "agnoster/agnoster-zsh-theme"
        "davidde/git"
      ];
    };

    initExtra = ''
      setopt NO_NOMATCH
    '';

  };
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
  };
}
