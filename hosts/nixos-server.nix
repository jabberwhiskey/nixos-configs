{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../hardware/nucserver.nix
    ../user/minimal-user.nix
    ../system/minimal-basic.nix
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
  services.tailscale.useRoutingFeatures = "both";
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
#      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };
  environment.systemPackages = with pkgs; [
    mc
    htop
  ];
  users.users.jcw = {
     extraGroups = [ "jellyfin" "sonarr" ];
    };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 80 9091 51413];
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
}
