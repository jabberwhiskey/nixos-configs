{ config, pkgs, ... }:

{
  home = {
    username = "jcw";
    homeDirectory = "/home/jcw";
    packages = with pkgs; [
      btop
      htop
      bitwarden
      bitwarden-cli
      firefox
      vivaldi
      unzip
      yt-dlp
    ];
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
      enableAutosuggestions = true;
      enableCompletion = true;
      history.expireDuplicatesFirst = true;
      initExtra = ''
        setopt NO_NOMATCH
      '';
      antidote = {
        enable = true;
        "agnoster/agnoster-zsh-theme"
      };
    };
  };
}
