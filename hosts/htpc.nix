
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware/htpc.nix
      ../system/systemd-tailscale.nix
      ../system/bluetooth.nix
      ../system/kernel-latest.nix
      ../system/systemdboot.nix
      ../system/steam.nix
      ../system/tailscale.nix
      ../system/basic.nix
      ../system/plasma.nix
    ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jcw = {
      home.stateVersion = "25.05";
      programs.kodi = {
        enable = true;
        package = pkgs.kodi-wayland.withPackages (kodiPkgs: with kodiPkgs; [
		      jellyfin
          youtube
          upnext
          inputstreamhelper
	      ]);
      };
    };
    users.jcw = {
      imports = [
        ../home/bash.nix
        ../home/home.nix
      ];
    };
  };
  security.pam.services.jcw.kwallet.enable = true;
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "jcw";
    };
    sddm = {
      autoLogin.relogin = true;
    };
    defaultSession = "plasma";
  };
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  environment.systemPackages = [
    pkgs.retroarch-full
  ];
  networking.hostName = "htpc";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";
}
