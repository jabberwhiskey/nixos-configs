
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
      (pkgs.kodi-gbm.withPackages (kodiPkgs: with kodiPkgs; [
		    jellyfin
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
  networking.hostName = "htpc";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };
  networking.firewall.enable = true;

}
