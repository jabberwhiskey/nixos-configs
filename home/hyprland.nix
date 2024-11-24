{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [
      imv
      waybar
      qpwgraph
      pcmanfm-qt
      ranger
      brillo
      kdePackages.kasts
      qt6ct
      kdePackages.breeze-icons
      kdePackages.breeze
    ];
  };
  gtk = {
    cursorTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-cursor;
      size = 24;
    };
    iconTheme = {
      name = "rose-pine-icons";
      package = pkgs.rose-pine-icon-theme;
    };
    theme = {
      name = "rose-pine-gtk";
      package = pkgs.rose-pine-gtk-theme;
    };
    enable = true;
  };
  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "rose-pine-cursor";
    size = 24;
    gtk.enable = true;
  };
  qt = {
    platformTheme.name = "qtct";
    style = {
      name = "breeze";
      package = pkgs.kdePackages.qt6ct;
    };
    enable = true;
  };
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
#      "$term" = "${pkgs.alacritty}/bin/alacritty";
      "$term" = "${pkgs.foot}/bin/foot";
      "$fileManager" = "${pkgs.pcmanfm-qt}/bin/pcmanfm-qt";
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,rose-pine"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE, 24"
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
        "col.active_border" = "rgba(c0c0c0ee) rgba(ffffffee) 66deg";
        "col.inactive_border" = "rgba(000000aa)";
        layout = "dawindle";
        allow_tearing = "false";
      };
      decoration = {
        rounding = "5";
        blur = {
          enabled = "true";
          size = "3";
          passes = "1";
          vibrancy = "0.1696";
        };
 #       "col.shadow" = "rgba(1a1a1aee)";
 #       drop_shadow = "true";
 #       shadow_range = "4";
 #       shadow_render_power = "3";
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
          "$mod, P, pseudo," #dwindle
          "$mod, V, togglesplit," #dwindle
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
          "$mod, S, togglespecialworkspace, SCRTCHPD"
          "$mod SHIFT, S, movetoworkspace, special:SCRTCHPD"
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
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#eceff1";
        font = "Droid Sans 9";
      };
      urgency_normal = {
        background = "#37474f";
        foreground = "#eceff1";
        timeout = 10;
      };
    };
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }      
        
      ]; 
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };
  
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
    
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "'\'Password...'\'";
          shadow_passes = 2;
        }
      ]; 
    };
  };
  programs.wpaperd = {
    enable = true;
    settings = {
      any = {
        path = "${config.home.homeDirectory}/Pictures/Wallpapers";
        sorting = "descending";
        duration = "10m";
      };
    };
  };
#  programs.alacritty = {
#    enable = true;
#    settings = {
#      window = {
#        decorations = "none";
#        blur = true;
#        opacity = 0.8;
#      };
#    };
#  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        app-id = "foot";
      	font = "monospace:size=14";
      };
      colors = {
        alpha = 0.9;
        background = "242424";
      	foreground = "ffffff";
      };
    };
  };
  programs.ranger = {
    enable = true;
    extraConfig = ''
      set preview_images true
      set preview_images_method sixel
    '';
  };
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.foot}/bin/foot";
    package = pkgs.rofi-wayland;
    theme = "android_notification";
    
  };
  services.clipman = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };
  services.playerctld = {
    enable = true;
  };
}
