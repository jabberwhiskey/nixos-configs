{
  #  home = {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 45;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "idle_inhibitor"
          "wireplumber"
          "tray"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          show-special = true;
        };
        "hyprland/window" = {
        };
        "clock" = {
          interval = 1;
          format = "{:%I:%M %p}";
          format-alt = "{:%A, %B %d, %Y (%r)}";
          tooltip-format = "\n<span size='9pt'> <tt><small>{calendar}</small></tt></span>";
          calendar = {
            "mode" = "year";
            "mode-mon-col" = 3;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format_icons = {
            activated = "";
            deactivated = "";
          };
        };
        "bluetooth" = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
        "battery" = {
          #         bat = "BAT1";
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          max-length = 25;
        };
        "network" = {
          #          interface = "wlp170s0";
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname} ";
          format-disconnected = "";
          #format-disconnected= "";
          tooltip-format = "{ifname}";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };
        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = "";
          on-click = "qpwgraph";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        "tray" = {
          spacing = 10;
          icon-size = 20;
          show-passive-items = "true";
        };
      };
    };
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: Roboto, Helvetica, Arial, sans-serif, nerdfonts; 
          font-size: 15px;
          min-height: 0;
      }

      window#waybar {
          background: #000000;
          color: white;
      }

      tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
      }
      tooltip label {
        color: white;
      }

      #workspaces button {
          background: #000000;
          color: white;
          border-bottom: 1px solid transparent;
          padding: 0 5px;
      }

      #workspaces button.focused {
          background: #ff0000;
          border-bottom: 3px solid white;
      }

      #mode, #clock, #battery {
          padding: 0 10px;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #clock {
          background-color: #000000;
      }

      #battery {
          background-color:  #000000;
          color: white;
      }

      #battery.charging {
          color: green;
          background-color:  #000000;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: white;
          }
      }

      #battery.warning:not(.charging) {
          background:  #FF0000; 
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      #network {
          background: #000000;
          color: white;
          padding: 0 10px;
      }
      #wireplumber {
          background:  #000000;
          padding: 0 10px;
      }
      #tray {
          background: #000000;
          padding: 0 5px;
      }
      #bluetooth {
          background: #000000;
          color: white;
      }
    '';
  };
}
