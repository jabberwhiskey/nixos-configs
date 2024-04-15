{ config, pkgs, ...  }:
{
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
  }; 
  environment.systemPackages = [
    pkgs.lutris
    pkgs.gamescope
  ];
}
