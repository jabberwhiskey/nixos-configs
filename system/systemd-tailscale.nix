{
  #this is a service to turn off and on tailescale during suspend
  #when waking from sleep tailscale gets confused and machines dont have internet
  systemd.services.tailscale-off = {
    enable = true;
    description = "disables tailscale before suspend";
    wantedBy = [ "suspend.target" ];
    before = [ "suspend.target" ];
    script = "systemctl stop tailscaled.service";
  };
  systemd.services.tailscale-on = {
    enable = true;
    description = "enables tailscale after suspend";
    wantedBy = [ "suspend.target" ];
    after = [ "suspend.target" ];
    script = "systemctl start tailscaled.service";
  };
}
