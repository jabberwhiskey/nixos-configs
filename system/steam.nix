{ config, pkgs, lib, ...  }:
{
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
    extraCompatPackages = with pkgs; [
      steamtinkerlaunch
      proton-ge-bin
    ];
    package = pkgs.steam.override {
      extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
      extraPkgs =
        pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
	  libkrb5
          keyutils
          gamemode
        ];
    };
  }; 
  programs.gamemode.enable = true;
  environment.systemPackages = [
    pkgs.lutris
    pkgs.gamescope
    pkgs.steamtinkerlaunch
  ];

}
