{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      wl-clipboard
      cliphist
      hyprshot
      qpwgraph
      pcmanfm-qt
      brillo
      kdePackages.breeze-icons
      kdePackages.breeze
    ];
  };
  gtk = {
    cursorTheme = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 24;
    };
    iconTheme = {
      name = "rose-pine-icons";
      package = pkgs.rose-pine-icon-theme;
    };
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
    enable = true;
  };
  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;
    gtk.enable = true;
    enable = true;
  };
  qt = {
    platformTheme.name = "qtct";
    style = {
      name = "breeze";
      package = pkgs.kdePackages.qt6ct;
    };
    enable = true;
  };
  xdg.configFile.hypr = {
    source = ../extra/hyprland;
    recursive = true;
    target = "hypr";
    enable = true;
  };
  systemd.user.targets.hyprland-session = {
    Unit = {
      Description = "Hyprland session";
      BindsTo = "graphical-session.target";
      Wants = "graphical-session-pre.target";
      After = "graphical-session-pre.target";
      PropagatesStopTo = "graphical-session.target";
    };
  };
#  wayland.windowManager.hyprland = {
#    configType = "hyprlang";
#    #configType = "lua";
#    package = null;
#    portalPackage = null;
#    enable = true;
#    systemd.enable = true;
#    settings = {
#      monitor = [ ",preferred,auto,1" ];
#      exec-once = [
#      	"kwalletd6"
#        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
#        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
#      ];
#      "$mod" = "SUPER";
#      "$term" = "${pkgs.foot}/bin/foot";
#      "$fileManager" = "${pkgs.pcmanfm-qt}/bin/pcmanfm-qt";
#      env = [
#        "XCURSOR_SIZE,24"
#        "XCURSOR_THEME,rose-pine"
#        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
#        "HYPRCURSOR_SIZE, 24"
#        "QT_QPA_PLATFORMTHEME,qt6ct"
#        "XDG_CURRENT_DESKTOP,Hyprland"
#      ];
#      input = {
#        kb_layout = "us";
#        follow_mouse = "1";
#        sensitivity = "0";
#        touchpad = {
#          natural_scroll = false;
#        };
#      };
#      general = {
#        gaps_in = "5";
#        gaps_out = "10";
#        border_size = "2";
#        "col.active_border" = "rgba(c0c0c0ee) rgba(ffffffee) 66deg";
#        "col.inactive_border" = "rgba(000000aa)";
#        layout = "dwindle";
#        allow_tearing = "false";
#      };
#      decoration = {
#        rounding = "5";
#        blur = {
#          enabled = "true";
#          size = "3";
#          passes = "1";
#          vibrancy = "0.1696";
#        };
#        shadow.enabled = false;
#      };
#      group = {
#        "col.border_active" = "0xffffff";
#        "col.border_inactive" = "0x000000";
#        "col.border_locked_active" = "0x750000";
#        "col.border_locked_inactive" = "0x330d0d";
#        groupbar = {
#          enabled = true; 
#          gradients = true;
#          indicator_height = 4;
#          "col.active" = "0xffffff";
#          "col.inactive" = "0x000000";
#          "text_color" = "0x000000";
#          "text_color_inactive" = "0xffffff";
#        };
#      };
#      animations = {
#        enabled = "true";
#        bezier = "myBezier, 1, 0.81, 0.03, 0.34";
#        animation = [
#          "windows, 1, 5, default, popin 90%"
#          "windowsOut, 1, 7, default, popin 90%"
#          "border, 1, 10, default"
#          "borderangle, 1, 8, default"
#          "fade, 1, 7, default"
#          "workspaces, 1, 6, default"
#        ];
#      };
#      binds = {
#        workspace_back_and_forth = true;
#      };
#      dwindle = {
#        force_split = 2;
#        preserve_split = "true";
#      };
#      master = {
#        new_status = "slave";
#        new_on_top = true;
#      };
#      scrolling = {
#        fullscreen_on_one_column = true;
#
#      };
#
##      windowrule = [
##        "float,class:^(Bitwarden)$,title:^(Bitwarden)$"
##        "float,class:^(xdg-desktop-portal-gtk)$,title:^(All Files)$"
##        "float,class:^(Waydroid)$,title:^(Waydroid)$"
##        "float,class:^(mpv)$,title:^(mpv)$"
##      ];
#      windowrule = [
#        "match:class Bitwarden, match:title Bitwarden, workspace special:SCRTCHPD, float true, group set always, size monitor_w*0.5 monitor_h*0.5, center on"
#        "match:class xdg-desktop-portal-gtk, match:title All Files, float true"
#        "match:class Waydroid, match:title Waydroid, float true"
#        "match:class mpv, match:title mpv, float true"
#        "match:class imv, match:title imv, float true"
#        "match:workspace special:SCRTCHPD, float true"
#        "match:class Steam, match:title Steam, monitor 0"
#      ];
#      workspace = [
#        "special:SCRTCHPD, m[0]"
#        "1, m[0], defualt:true"
#        "10, layout:scrolling"
#        "9, layout:master"
#      ];
#      bind = [
#        #groups
#        "$mod SHIFT, code:59, moveintogroup, l" # ,
#        "$mod SHIFT, code:60, moveintogroup, r" # ,
#        "$mod, code:58, lockactivegroup, toggle" # m
#        "$mod Control_L, code:61, togglegroup," # /
#        "$mod, code:60, changegroupactive, f" # .
#        "$mod, code:59, changegroupactive, b" # ,
#        "$mod Alt, code:61, moveoutofgroup, active" # /
#        #dwindle layout
#        "$mod, U, layoutmsg, togglesplit" # dwindle
#        "$mod, I, layoutmsg, pseudo" # dwindle
#        #master layout
#        "$mod, B, layoutmsg, swapwithmaster ingnoremaster"
#        "$mod SHIFT, N, layoutmsg, swapnext"
#        "$mod ALT, N, layoutmsg, swapprev"
#        "$mod CONTROL_L, space, layoutmsg, removemaster"
#        "$mod ALT, space, layoutmsg, removemaster"
#        "$mod ALT, B, layoutmsg, rollnext"
#        #scrolling layout
#        "$mod, bracketright, layoutmsg, move +col"
#        "$mod, bracketleft, layoutmsg, move -col"
#        "$mod SHIFT, bracketright, layoutmsg, swapcol r"
#        "$mod SHIFT, bracketleft, layoutmsg, swapcol l"
#        "$mod ALT, code:51, layoutmsg, promote"
#        "$mod, code:51, layoutmsg, togglefit"
#        "$mod, P, layoutmsg, colresize +conf"
#        "$mod, O, layoutmsg, colresize -conf"
#    };
#  };
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
    waylandDisplay = "wayland-1";
  };
  services.hypridle = {
    enable = true;
    settings = {
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
  services.wpaperd = {
    enable = true;
    settings = {
      any = {
        path = "${config.home.homeDirectory}/Pictures/Wallpapers";
        sorting = "descending";
        duration = "10m";
      };
    };
  };
  programs.foot = {
    enable = true;
    settings = {
      main = {
        app-id = "foot";
        font = "monospace:size=14";
      };
      colors-dark = {
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
    theme = "android_notification";

  };
  services.clipman = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };
  services.playerctld = {
    enable = true;
  };
  systemd.user = {
    enable = true;
    services = {
      dunst = {
        Unit = {
          After = [ "hyprland-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.dunst}/bin/dunst";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
      wpaperd = {
        Unit = {
          Wants = [ "hyprland-session.target" ];
          ExecStart = "${pkgs.wpaperd}/bin/wpaperd";
        };
      };
    };
  };
}
