{ config, pkgs, ...}:

{
  imports = [
    ../user/user.nix
    ../system/common.nix
    ../system/systemdboot.nix

  ];
  system.stateVersion = "22.05";
  networking.hostName = "nixos-server";
  services.openssh = {
    enable = true;
    settings = {
      passwordAuthenticatiomn = false;
      kbdInteractiveAuthentication = false;
    };
  };
  environment.systemPackages = with pkgs; [
    mc
    htop
    fisn
  ];
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 8080 8989 13400];
  };
  systemd.tmpfiles.rules = [
    "Z /media/plex 0776 sonarr users"
    "z /media/nas 0777 jcw sonarr"
  ];
}

