{ config, pkgs, lib, ...  }:
{
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
    extraCompatPackages = with pkgs; [
      steamtinkerlaunch
    ];
  }; 
  environment.systemPackages = [
    pkgs.lutris
    pkgs.gamescope
    pkgs.steamtinkerlaunch
  ];
}
