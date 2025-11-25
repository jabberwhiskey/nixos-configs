
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
    users.jcw = {
      programs.zsh.shellAliases = {
        "update" = "sudo nixos-rebuild boot --flake ~/dev/nixos-configs#nixos-laptop --verbose";
        "test" = "sudo nixos-rebuild test --flake ~/dev/nixos-configs#nixos-laptop --verbose";
      };
      imports = [
        ../home/bash.nix
        ../home/home.nix
      ];
      home.stateVersion = "25.05";
    };
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  users.extraUsers.kodi = {
    isNormalUser = true;
    extraGroups = [
      "input"
    ];
  };
  services.getty.autologinUser = "kodi";
  let
    (pkgs.kodi-gbm.withPackages (kodiPkgs: with kodiPkgs; [
		  jellyfin
      youtube
      upnext
      inputstreamhelper
	  ]))
  in
  ];
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${pkgs.kodi-gbm}/bin/kodi";
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
