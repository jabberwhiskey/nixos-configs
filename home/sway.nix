{
  pkgs,
  config,
  lib,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";
      menu = "${pkgs.wofi}/bin/wofi";

      terminal = "${pkgs.alacritty}/bin/alacritty";

      workspaceAutoBackAndForth = true;
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
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-A.toml";
          position = "top";
          command = "${pkgs.sway}/bin/swaybar";
          id = "swaybar";
          trayPadding = 5;
          fonts = {
            names = ["DejaVu Sans Mono" "FontAwesome5Free"];
            style = "Bold Semi-Condensed";
            size = 11.0;
          };
        }
      ];

      startup = [
        {command = "mako";}
      ];
    };
    config = {
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
        inherit
          (config.wayland.windowManager.sway.config)
          left
          down
          up
          right
          menu
          terminal
          ;
      in {
        "${mod}+Alt+w" = "exec ${pkgs.firefox}/bin/firefox";
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+d" = "exec ${menu} -d --show=drun";
        "${mod}+Alt+b" = "exec ${pkgs.bitwarden}/bin/bitwarden";
        "${mod}+Alt+n" = "exec ${terminal} -e ${pkgs.nnn}/bin/nnn";
        "${mod}+Alt+m" = "exec ${terminal} -e ${pkgs.btop}/bin/btop";

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
        "${mod}+space" = "focus mode_toggle";
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
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'Do you want to exit Sway?' -b 'Yes, exit sway' 'swaymsg exit'";
        "${mod}+r" = "mode resize";

        "print" = "exec  ${pkgs.grim}/bin/grim -g- screenshot-$(date +%Y%m%d-%H%M%S).png";
        "${mod}+print" = "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g-  screenshot-$(date +%Y%m%d-%H%M%S).png";

        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";

        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 10";
        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 10";

        "${mod}+apostrophe" = "move workspace to output right";

        "${mod}+minus" = "scratchpad show";
        "${mod}+underscore" = "move container to scratchpad";
      };
      floating.criteria = [
        {class = "Bitwarden";}
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
      output * background '~/Pictures/wallpapers/wallpaper1.jpg'  fill
      exec_always sworkstyle &> /tmp/workstyle.log
    '';
    swaynag = {
      enable = true;
    };
  };
  programs.wofi = {
    enable = true;
    style = ''
      backround-color: #5A5A5A;
    '';
    settings = {
       term = "alacritty -e";
#      term = "${pkgs.alacritty}/bin/alacritty";
      width = "25%";
      allow_images = true;
    };
  };
  programs.i3status-rust = {
    enable = true;
    bars = {
      A = {
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
          {block = "sound";}
          {
            block = "time";
            interval = 60;
            format = " $timestamp.datetime(f:'%a %d/%m %I:%M %p') ";
          }
        ];
        settings = {
          theme = {
            theme = "solarized-dark";
            overrides = {
              idle_bg = "#123456";
              idle_fg = "#abcdef";
            };
          };
        };
        icons = "awesome5";
        theme = "gruvbox-dark";
      };
    };
  };
  home.packages = with pkgs; [
    grim
    swaylock-effects
    slurp
    light
    swayest-workstyle
  ];
  home.sessionVariables = {
    TERMINAL = "alacritty";
    BROSWER = "firefox";
  };

  services.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
 
      {
        timeout = 300;
        command = ''          ${pkgs.swaylock-effects}/bin/swaylock  --screenshots \
          	 --clock \
          	 --indicator \
          	 --indicator-radius 100 \
          	 --indicator-thickness 7 \
          	 --effect-blur 7x5 \
          	 --effect-vignette 0.5:0.5 \
          	 --ring-color bb00cc \
          	 --key-hl-color 880033 \
          	 --line-color 00000000 \
          	 --inside-color 00000088 \
          	 --separator-color 00000000 \
          	 --grace 2 \
          	 --fade-in 0.2'';
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = ''          ${pkgs.swaylock-effects}/bin/swaylock --screenshots \
                    --clock \
          	 --indicator \
          	 --indicator-radius 100 \
          	 --indicator-thickness 7 \
          	 --effect-blur 7x5 \
          	 --effect-vignette 0.5:0.5 \
          	 --ring-color bb00cc \
          	 --key-hl-color 880033 \
          	 --line-color 00000000 \
          	 --inside-color 00000088 \
          	 --separator-color 00000000 \
          	 --grace 2 \
          	 --fade-in 0.2'';
      }
    ];
  };
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
        blur = true;
        opacity = 0.8;
      };
    };
  };
  services.dunst = {
    enable = true;
  };
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeBlue;
    size = 25;
    name = "Catppuccin-Frappe-Blue-Cursors";
  };
  programs.nnn = {
    enable = true;
  };
}
