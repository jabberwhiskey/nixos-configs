{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.packages = [ pkgs.wayland-pipewire-idle-inhibit ];
  #  services.wayland-pipewire-idle-inhibit = {
  #    enable = true;
  #    systemdTarget = "hyprland-session.target";
  #    settings = {
  #      verbosity = "INFO";
  #      media_minimum_duration = 10;
  #      idle_inhibitor = "wayland";
  #      sink_whitelist = [
  #      ];
  #    };
  #  };
  home.file."${config.xdg.configHome}/wayland-pipewire-idle-inhibit/config.toml" = {
    text = ''
      verbosity = "WARN"
      media_minimum_duration = 5
      idle_inhibitor = "wayland"
      sink_whitelist = [ ]
      node_blacklist = [ ]
    '';
    enable = true;
  };
  systemd.user.services = {
    wayland-pipewire-idle-inhibit = {
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
      Unit = {
        Description = "dbus audio idle inhibitor";
        Documentation = [ "https://github.com/rafaelrc7/wayland-pipewire-idle-inhibit" ];
      };
      Service = {
        ExecStart = "${pkgs.wayland-pipewire-idle-inhibit}/bin/wayland-pipewire-idle-inhibit";
        Restart = "always";
        RestartSec = 10;
      };
    };
  };
}
