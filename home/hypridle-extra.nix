{ config, pkgs, ... }:
{
  services.hypridle = {
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 1800;
          on-timeout = "systemctl suspend"; 
        }
      ];
    };
  };
}
