{ home-manager, pkgs, config, inputs, lib, ... }:
{
  imports = [
    ../home/sway.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  home = {
    username = "jcw";
    homeDirectory = "/home/jcw";
  };
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  targets.genericLinux.enable = true;
}
