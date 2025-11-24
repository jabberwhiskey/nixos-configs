
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware/htpc.nix
      ../system/systemdboot.nix
      ../system/tailscale.nix
      ../system/minimal-basic.nix
    ];
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  users.extraUsers.kodi.isNormalUser = true;
  services.cage.user = "kodi";
  services.cage.program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
  services.cage.enable = true;
  environment.systemPackages = [
	(pkgs.kodi-wayland.withPackages (kodiPkgs: with kodiPkgs; [
		jellyfin
	]))
];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

}
