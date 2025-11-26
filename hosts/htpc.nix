
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware/htpc.nix
      ../system/systemdboot.nix
      ../system/tailscale.nix
      ../system/minimal-basic.nix
    ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.kodi = {
      home.stateVersion = "25.05";
      programs.kodi = {
        enable = true;
        package = pkgs.kodi.withPackages (kodiPackages: with kodiPackages; [
          youtube
	  inputstream-adaptive
	  inputstream-rtmp
	  jellyfin
	  upnext
        ]);      
      };
    };
    users.jcw = {
      imports = [
        ../home/bash.nix
      ];
      home.stateVersion = "25.05";
    };
  };
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  nixpkgs.config.kodi = {
    kodiPackages.youtube = true;
  };
  users.extraUsers.kodi = {
    isNormalUser = true;
    extraGroups = [
      "input"
    ];
  };
  
  services.xserver.enable = true;
  services.xserver.desktopManager.kodi.enable = true;
  services.xserver.desktopManager.kodi.package = pkgs.kodi-gbm.withPackages (p: [
    p.youtube
    p.inputstream-adaptive
  ]);
  services.displayManager.autoLogin.user = "kodi";
  services.xserver.displayManager.lightdm.greeter.enable = false;
#  services.getty.autologinUser = "kodi";
#  services.greetd = {
#    enable = true;
#    settings = {
#      initial_session = {
#        command = "${pkgs.kodi-gbm}/bin/kodi-standalone";
#        user = "kodi";
#      };
#      default_session = {
#        command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";
#      };
#    };
#  };
#
#  programs.sway = {
#    enable = true;
#    xwayland.enable = false;
#  };
#  # use alsa; which supports hdmi passthrough
#  services.pulseaudio.enable = false;
#  services.pipewire.enable = false;
  services.pipewire.enable = false;

  networking.hostName = "htpc";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

  networking.firewall.enable = true;

}
