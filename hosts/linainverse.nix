{ home-manager, pkgs, config, inputs, lib, ... }:
{
  imports = [
    ../home/sway.nix
    ../home/bash.nix
    ../home/sway-inhibit.nix
    ../home/zsh.nix
    ../home/nvim.nix
    ../home/home.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  home = {
    username = "jcw";
    homeDirectory = "/home/jcw";
    packages = with pkgs; [
      btop
    ];
  };
  #wayland.windowManager.sway.package =  pkgs.emptyFile;
  wayland.windowManager.sway.package =  null;
  programs.git = {
    enable = true;
    userName = "jcw";
    userEmail = "github.u9l99@aleeas.com";
  };
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  targets.genericLinux.enable = true;
  programs.foot = {
    enable = true;
#    package = null;
    settings = {
      main = {
        app-id = "foot";
      	font = "monospace:size=12";
      };
      colors = {
        alpha = 0.9;
        background = "242424";
      	foreground = "ffffff";
      };
    };
  };
}

