{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [
      anyrun
      imv
      rofi-wayland
      helvum
      waybar
      pcmanfm-qt
      ranger
      wl-clipboard
      swaylock-effects
      kdePackages.kasts
      qt6ct
      qt6ct
      kdePackages.breeze-icons
      kdePackages.breeze
    ];
  };
  gtk = {
    theme = {
      name = "Adwaita-Dark";
      package = pkgs.gnome-themes-extra;
    };
    enable = true;

  };
#  qt = {
#    platformTheme.name = "qtct";
#    style = {
#      name = "breeze";
#      package = pkgs.kdePackages.qt6ct;
#    };
#    enable = true;
#  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      monitor = [",preferred,auto,1"];
      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.dunst}/bin/dunst"
        "${pkgs.wpaperd}/bin/wpaperd"
      ];
      "$mod" = "SUPER";
      "$term" = "${pkgs.alacritty}/bin/alacritty";
      "$fileManager" = "${pkgs.pcmanfm-qt}/bin/pcmanfm-qt";
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt6ct"
	"XDG_CURRENT_DESKTOP,Hyprland"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = "1";
        sensitivity = "0";
        touchpad = {
          natural_scroll = false;
        };
      };
      general = {
        gaps_in = "5";
        gaps_out = "10";
        border_size = "2";
        "col.active_border" = "rgba(00f8ffee) rgba(e80e0eee) 10deg";
        "col.inactive_border" = "rgba(000000aa)";
        layout = "dawindle";
        #allow_tearring = "false";
      };
      decoration = {
        rounding = "5";
        blur = {
          enabled = "true";
          size = "3";
          passes = "1";
          vibrancy = "0.1696";
        };
        "col.shadow" = "rgba(1a1a1aee)";
        drop_shadow = "true";
        shadow_range = "4";
        shadow_render_power = "3";
      };
      animations = {
        enabled = "true";
        bezier = "myBezier, 1, 0.81, 0.03, 0.34";
        animation = [
          "windows, 1, 5, default, popin 90%"
          "windowsOut, 1, 7, default, popin 90%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = "true";
        preserve_split = "true";
      };
      master = {
        new_status = "true";
      };
      gestures = {
        workspace_swipe = "false";
      };
      windowrulev2 = [
        "float,class:^(Bitwarden)$,title:^(Bitwarden)$"
        "float,class:^(Waydroid)$,title:^(Waydroid)$"
      ];
      windowrule = [
        "float,^(imv)$"
        "float,^(mpv)$"
      ];
      bind =
        [
          "$mod, Return, exec, $term"
          "$mod, C, killactive,"
          "$mod SHIFT, Q, exit,"
          "$mod, E, exec, $fileManager"
          "$mod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"
          "$mod, R, exec, ${pkgs.anyrun}/bin/anyrun"
          "$mod, P, pseudo," #dwindle
          "$mod, J, togglesplit," #dwindle
          "$mod, F, togglefloating,"
          "$mod SHIFT, F,fullscreen"
          ", Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m output" 
          "SHIFT, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"
          "Alt, Print, exec, ${pkgs.hyprshot}/bin/hyprshot -m active"
          #move focus
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          #move window
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          #scratchpad
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"
          #brightness
          ",XF86MonBrightnessDown,exec, ${pkgs.brillo}/bin/brillo -q -U 5"
          ",XF86MonBrightnessUp, exec, ${pkgs.brillo}/bin/brillo -q -A 5"
          #mute, volume is under binde
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          #playerctl
          ", XF86AudioPrev, exec, plyerctl previous"
          ", XF86AudioNext, exec, plyerctl next"
          ", XF86AudioPlay, exec, plyerctl play-pause"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      binde = [
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        #resize window
        "$mod Alt, up, resizeactive, 0 10"
        "$mod Alt, down, resizeactive, 0 -10"
        "$mod Alt, right, resizeactive, 10 0"
        "$mod Alt, left, resizeactive, -10 0"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
  services.dunst = {
    enable = true;
  };
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    timeouts = [
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
#      {
#        timeout = 600;
#        command = "${pkgs.systemd}/bin/systemctl suspend";
#      }
    ];
#    events = [
#      {
#        event = "before-sleep";
#        command = ''          ${pkgs.swaylock-effects}/bin/swaylock --screenshots \
#                    --clock \
#          	  --indicator \
#          	  --indicator-radius 100 \
#          	  --indicator-thickness 7 \
#          	  --effect-blur 7x5 \
#          	  --effect-vignette 0.5:0.5 \
#          	  --ring-color bb00cc \
#          	  --key-hl-color 880033 \
#          	  --line-color 00000000 \
#          	  --inside-color 00000088 \
#          	  --separator-color 00000000 \
#          	  --grace 2 \
#          	  --fade-in 0.2'';
#      }
#    ];
  };
  programs.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = "${config.home.homeDirectory}/Pictures/Wallpapers";
        sorting = "descending";
        duration = "10m";
      };
    };
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
  services.clipman = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };
  services.playerctld = {
    enable = true;
  };
}
