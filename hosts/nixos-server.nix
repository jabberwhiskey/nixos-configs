{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../hardware/nucserver.nix
    ../system/minimal-basic.nix
    ../system/nfs-host.nix
    ../system/server-torrent.nix
    ../system/tailscale.nix
    ../system/sonarr.nix
    ../system/jellyfin.nix
    ../system/systemdboot.nix
  ];
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  system.stateVersion = "22.05";
  networking.hostName = "nixos-server";
  networking.firewall.checkReversePath = "loose";
  services.tailscale.useRoutingFeatures = "both";

  environment.systemPackages = with pkgs; [
    mc
    htop
    wireguard-tools
  ];
  users.users.jcw = {
    extraGroups = [
      "jellyfin"
      "sonarr"
    ];
  };
  systemd.tmpfiles.settings = {
    "10-perms_for_nas" = {
      "/media/nas" = {
        Z = {
          user = "jcw";
          group = "users";
          mode = "0776";
        };
      };
    };
    "10-perms_for_media" = {
      "/media/plex" = {
        Z = {
          user = "jcw";
          group = "users";
          mode = "0776";
        };
      };
    };
  };
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.wg-quick.interfaces = {
    wg0 = {
      table = 1000; 
      configFile = "/nixos-server0-US-AZ-96.conf";
    };
  };
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };
}
