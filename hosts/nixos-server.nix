{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../hardware/nucserver.nix
    ../user/user.nix
    ../system/basic.nix
    ../system/server-torrent.nix
    ../system/tailscale.nix
    ../system/sonarr.nix
    ../system/jellyfin.nix
    ../system/systemdboot.nix
  ];
#  users.users.jcw.openssh.authorizedKeys.keyFiles = [
#    ./keys/keys
#  ];
  system.stateVersion = "22.05";
  networking.hostName = "nixos-server";
  services.tailscale.useRoutingFeatures = "server";
  services.openssh = {
    enable = true;
    settings = {
#      PasswordAuthentication = false;
      PasswordAuthentication = true;
#      KbdInteractiveAuthentication = false;
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
    allowedTCPPorts = [22 80 443 8080 8989 13400];
  };
  systemd.tmpfiles.rules = [
    "Z /media/plex 0776 sonarr users"
    "z /media/nas 0777 jcw sonarr"
  ];
}
