{config, pkgs, lib, ...}:
{
  home = {
    packages = with pkgs; [
      wofi
      ranger
      grim
      slurp
      wl-clipboard
      swayimg
      swaylock-effects
      playerctl
    ];
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
      "$term" = "${pkgs.alacritty}/bin/alacritty";
      "$fileManager" = "${pkgs.ranger}/bin/ranger";
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];
      input = {
        kb_layout = "us";
	follow_mouse =  "1";
	sensitivity = "0";
	touchpad = {
	  natural_scroll = false; 
	};
      };
      general = {
        gaps_in = "5";
	gaps_out = "10";
	border_size = "2";
	"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
	"col.inactive_border" = "rgba(595959aa)";
	layout = "dwindle";
	#allow_tearring = "false";
      };
      decoration = {
        rounding = "10";
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
	bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
	animation = [ 
	  "windows, 1, 7, default, popin 80%"
	  "windowsOut, 1, 7, default, popin 80%"
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
        new_is_master = "true";
      };
      gestures = {
        workspace_swipe = "false";
      };
      windowrulev2 = [
        "float,class:^(Bitwarden)$,title:^(Bitwarden)$"
      ];
      windowrule = [
        "float,^(swayimg)$"
      ];
      bind = [
        "$mod, Return, exec, $term"
        "$mod, C, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, E, exec, $term -e $fileManager"
        "$mod, D, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "$mod, P, pseudo," #dwindle
        "$mod, J, togglesplit," #dwindle
        "$mod, F, togglefloating,"
        "$mod SHIFT, F,fullscreen"
	", Print, exec, ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.wl-clipboard}/bin/wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | ${pkgs.dunst}/bin/dunstify 'Screenshot of whole screen taken'"
	"SHIFT, Print, exec, ${pkgs.grim}/bin/grim -g | '$(slurp)'  - | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.wl-clipboard}/bin/wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | ${pkgs.dunst}/bin/dunstify 'Screenshot of the region taken' -t 1000 "
        #move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
	#resize window
	"$mod Alt, up, resizeactive 0 10"
	"$mod Alt, down, resizeactive 0 -10"
	"$mod Alt, right, resizeactive 10 0"
	"$mod Alt, left, resizeactive -10 0"
	#move window
	"$mod SHIFT, up, movewindow u"
	"$mod SHIFT, down, movewindow d"
	"$mod SHIFT, left, movewindow l"
	"$mod SHIFT, right, movewinoow r"
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
      ++(
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
	command = ''${pkgs.swaylock-effects}/bin/swaylock  --screenshots \
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
      {
        timeout = 600;
	command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
	command = ''${pkgs.swaylock-effects}/bin/swaylock --screenshots \
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
  programs.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = "/home/jcw/Pictures/wallpapers/framework";
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
}
