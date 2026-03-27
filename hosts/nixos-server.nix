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
  networking.firewall.checkReversePath = false;
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
  networking.wireguard = {
    enable = true;
    interfaces = {
      wg1 = {
        ips = [ "10.2.0.2/32" "2a07:b944::2:2/128"];
        privateKeyFile = "/privatekey";
        peers = [{
          endpoint = "193.37.254.66:51820";
          allowedIPs = [ "0.0.0.0/0" "::/0"];
          publicKey = "qDJgY2K+GtC/geqxLN2ZO61LHlwENsMpapC1eGF21mM=";
          persistentKeepalive = 25;
        }];
        extraOptions = {
          DNS =  "10.2.0.1, 2a07:b944::2:1";
        };
      };
    };
  };
  systemd.targets.wireguard-wg1.after = [ "network-online.target" ];
  systemd.targets.wireguard-wg1.requires = [ "network-online.target" ];
}
