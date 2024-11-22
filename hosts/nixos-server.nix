{
  config,
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
    ../users/keys
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
  systemd.tmpfiles.rules = [
    "Z /media/plex 0776 sonarr users"
    "z /media/nas 0777 jcw sonarr"
  ];
}
