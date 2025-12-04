{
  pkgs,
  config,
  lib,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = rec {
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      menu = "rofi";

      terminal = "foot";

      workspaceAutoBackAndForth = true;
      input = {
        "type:keyboard" = {
          xkb_options = "caps:swapescape";
        };
        "type:touchpad" = {
          dwt = "enabled";
          dwtp = "enabled";
          tap = "enabled";
          tap_button_map = "lrm";
        };
      };
      output = {
        "*" = {
          bg = "${config.home.homeDirectory}/Pictures/Wallpapers/1382343.jpg fill";
        };
      };
      defaultWorkspace = "workspace number 1";
      colors = {
        focused = {
          background = "#630000";
          border = "#6b1818";
          childBorder = "#630000";
          indicator = "#db4d4d";
          text = "#ffffff";
        };
      };
      window = {
        titlebar = true;
        hideEdgeBorders = "both";
        commands = [
          {
            command = "inhibit_idle fullscreen";
            criteria.class = "mpv";
          }
        ];
      };

      bars = [
        {
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
          position = "top";
          command = "swaybar";
          id = "swaybar";
          trayPadding = 5;
          fonts = {
            names = [
              "DejaVu Sans Mono"
              "FontAwesome6Free"
            ];
            style = "Bold Semi-Condensed";
            size = 10.0;
          };
          colors = {
            background = "#000000";
            statusline = "#fa2802";
            focusedWorkspace = {
              background = "#bd1a1a";
              border = "#fa6e6e";
              text = "#000000";
            };
            inactiveWorkspace = {
              background = "#000000";
              border = "#000000";
              text = "#fa6e6e";
            };
          };
        }
      ];

      startup = [
        { command = "dunst"; }
        #        {command = "nixGL ${pkgs.wpaperd}/bin/wpaperd";}
      ];
    };
    config = {
      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          inherit (config.wayland.windowManager.sway.config)
            left
            down
            up
            right
            menu
            terminal
            ;
        in
        {
          "${mod}+Return" = "exec ${terminal}";
          "${mod}+d" = "exec ${menu}  -show drun";

          "${mod}+c" = "kill";
          "${mod}+${left}" = "focus left";
          "${mod}+${down}" = "focus down";
          "${mod}+${up}" = "focus up";
          "${mod}+${right}" = "focus right";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${right}" = "move right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+m" = "focus mode_toggle";
          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+comma" = "layout stacking";
          "${mod}+period" = "layout tabbed";
          "${mod}+slash" = "layout toggle split";
          "${mod}+a" = "focus parent";
          "${mod}+s" = "focus child";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" =
            "exec swaynag -t warning -m 'Do you want to exit Sway?' -b 'Yes, exit sway' 'swaymsg exit'";
          "${mod}+r" = "mode resize";

          "print" = "exec grim  ~/Pictures/screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png";
          "Shift+print" =
            "exec slurp | grim -g -  ~/Pictures/screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png";

          "XF86AudioMute" = "exec /bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec /bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec /bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";

          "XF86MonBrightnessUp" = "exec light -A 10";
          "XF86MonBrightnessDown" = "exec light -U 10";

          "${mod}+apostrophe" = "move workspace to output right";
          "${mod}+Alt+space" = "exec dunstctl history-pop";
          "${mod}+space" = "exec dunstctl close-all";

          "${mod}+minus" = "scratchpad show";
          "${mod}+underscore" = "move container to scratchpad";
        };
      floating.criteria = [
        { class = "Bitwarden"; }
      ];

      gaps = {
        horizontal = 5;
        vertical = 5;
        inner = 5;
        outer = 5;
        smartBorders = "on";
        smartGaps = true;
      };
    };
    systemd.enable = true;
    extraConfig = ''
      bindswitch --reload --locked lid:on exec '/bin/swaylock -i ${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper2.png -s fill'
    '';
    swaynag = {
      enable = true;
    };
  };
  #  programs.wofi = {
  #    enable = true;
  #    style = ''
  #      backround-color: #5A5A5A;
  #    '';
  #    settings = {
  #       term = "alacritty -e";
  #      term = "${pkgs.alacritty}/bin/alacritty";
  #      width = "25%";
  #      allow_images = true;
  #    };
  #  };
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        blocks = [
          {
            block = "battery";
            interval = 20;
            format = " $icon - $percentage{$time |} ";
          }
          {
            block = "cpu";
            interval = 5;
          }
          {
            block = "net";
            interval = 5;
          }
          { block = "sound"; }
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %I:%M %p') ";
          }
        ];
        settings = {
          theme = {
            theme = "native";
            overrides = {
              #              idle_bg = "#ff0303";
              idle_bg = "#000000";
              #              idle_fg = "#000000";
              idle_fg = "#ff0303";
              seperator = "f74d4d";
            };
          };
        };
        icons = "awesome4";
        theme = "gruvbox-dark";
      };
    };
  };
  home.packages = with pkgs; [
    swayimg
    rofi
  ];
  home.sessionVariables = {
    TERMINAL = "foot";
    BROSWER = "firefox";
  };

  services.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";
    timeouts = [
      {
        timeout = 600;
        command = "/bin/systemctl suspend";
      }

      {
        timeout = 300;
        command = "/bin/swaylock -i ${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper2.png -s fill";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "/bin/swaylock -i ${config.home.homeDirectory}/Pictures/Wallpapers/wallpaper2.png -s fill";

      }
    ];
  };
  services.dunst = {
    enable = true;
  };
}
