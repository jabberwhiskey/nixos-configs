{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../user/user.nix
    ../system/common.nix
    ../system/server-torrent.nix
    ../system/tailscale.nix
    ../system/systemdboot.nix
  ];
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
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
  users.users.jcw = {
     extraGroups = [ "jellyfin" "sonarr" ];
     shell = pkgs.fish;
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
