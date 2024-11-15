{
  users.users.qbittorrent = {
    isNormalUser = false;
    extraGroups = [ "sonarr" "users" ];
  };
  environment.systemPackages = with pkgs; [ qbittorrent-nox ];
  # add and enable systemd unit
  systemd = {
    packages = [ pkgs.qbittorrent-nox ];
    services."qbittorrent-nox@fc" = {
      enable = true;
      serviceConfig = {
        Type = "simple";
        User = "qbittorrent";
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 8080 ];
}
