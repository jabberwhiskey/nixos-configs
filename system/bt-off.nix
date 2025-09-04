{
  #this is a service to turn off and on bluetooth during suspend
  systemd.services.bluetooth-off = {
    enable = true;
    description = "disables bluetooth before suspend";
    wantedBy = [ "suspend.target" ];
    before = [ "suspend.target" ];
    script = "systemctl stop bluetooth.service";
  };
  systemd.services.bluetooth-on = {
    enable = true;
    description = "enables bluetooth after suspend";
    wantedBy = [ "suspend.target" ];
    after = [ "suspend.target" ];
    script = "systemctl start bluetooth.service";
  };
}
