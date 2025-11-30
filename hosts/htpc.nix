
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware/htpc.nix
      ../system/systemdboot.nix
      ../system/steam.nix
      ../system/tailscale.nix
      ../system/basic.nix
    ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.kodi = {
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
      home.stateVersion = "25.05";
        home.file.widevine-lib.source = "${pkgs.unfree.widevine-cdm}/share/google/chrome/WidevineCdm/_platform_specific/linux_x64/libwidevinecdm.so";
        home.file.widevine-lib.target = ".kodi/cdm/libwidevinecdm.so";
        home.file.widevine-manifest.source = "${pkgs.unfree.widevine-cdm}/share/google/chrome/WidevineCdm/manifest.json";
        home.file.widevine-manifest.target = ".kodi/cdm/manifest.json";

    };
  };
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  services.cage.user = "jcw";
  services.cage.program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
  services.cage.enable = true;

  networking.hostName = "htpc";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

  networking.firewall.enable = true;

}
