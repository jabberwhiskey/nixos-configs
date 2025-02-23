{ home-manager, pkgs, config, inputs, lib, ... }:
{
  imports = [
    ../home/sway.nix
    ../home/bash.nix
    ../home/zsh.nix
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
  programs.git = {
    enable = true;
    userName = "jcw";
    userEmail = "github.u9l99@aleeas.com";
  };
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  targets.genericLinux.enable = true;
}
