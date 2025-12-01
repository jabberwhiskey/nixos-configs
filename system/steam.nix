{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    localNetworkGameTransfers.openFirewall = true;
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
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        reaper_freq = 5;
        desiredgov = "performance";
        desiredprof = "performance";
        softrealtime = "auto";
        inhibit_screensaver = 1;
        renice = 0;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        amd_perfprmance_level = "high";
      };
      cpu = {
        park_cores = "yes";
        pin_cores = "yes";
      };
    };
  };
  environment.systemPackages = [
#    pkgs.lutris
    pkgs.gamescope
    pkgs.steamtinkerlaunch
    pkgs.lm_sensors
  ];
  users.users.jcw.extraGroups = [ "gamemode" ];
}
