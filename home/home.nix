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
      ranger
    ];
  };
