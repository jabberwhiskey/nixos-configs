
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
    environment.systemPackages = [
      (pkgs.kodi.withPackages (kodiPkgs: with kodiPkgs; [
		    jellyfin
        youtube
        upnext
  	  ]))
    ];
  users.extraUsers.kodi = {
    isNormalUser = true;
    extraGroups = [
      "input"
    ];
  };
  services.getty.autologinUser = "kodi";
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.kodi-gbm}/bin/kodi-standalone";
        user = "kodi";
      };
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";
      };
    };
  };

  programs.sway = {
    enable = true;
    xwayland.enable = false;
  };
  # use alsa; which supports hdmi passthrough
  services.pulseaudio.enable = false;
  services.pipewire.enable = false;

  networking.hostName = "htpc";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

  networking.firewall.enable = true;

}
