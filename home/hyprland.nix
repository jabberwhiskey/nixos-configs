{config, pkgs, lib, ...}:
{
  home = {
   # xdg.configFile."hyprland".source = "${dotfiles}/hypr/hyprland";
    packages = with pkgs; [
      wofi
      ranger
      swaylock-effects
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
      bind = [
        "$mod, Return, exec, $term"
        "$mod, C, killactive,"
        "$mod SHIFT, Q, exit,"
        "$mod, E, exec, $term -e $fileManager"
        "$mod, D, exec, ${pkgs.wofi}/bin/wofi --show drun "
        "$mod, P, pseudo," #dwindle
        "$mod, J, togglesplit," #dwindle
        "$mod, F, togglefloating,"
        "$mod SHIFT, F,fullscreen"
        #move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        #scratchpad
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
	#brightness
        ",XF86MonBrightnessDown,exec, ${pkgs.brillo}/bin/brillo -q -U 5"
        ",XF86MonBrightnessUp, exec, ${pkgs.brillo}/bin/brillo -q -A 5"
	#mute, volume is under binde
	", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
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
  gtk = {
    cursorTheme = {
      name = "Capitaine Cursors";
      pacakge = pkgs.capitaine-cursors-themed;
      size = 36;
    };
  };
  services.dunst = {
    enable = true;
  };
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    timeouts = [
#      {timeout = 240; command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";}
      {timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator indicator-radius 100 --indicator-thickness 7 --effect-vifnette 0.5:0.5 --effect-blur 7x5 --ringcolor bb00cc --grace 4 --fade-in 0.3 ";}
      {timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend";}
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
	opacity = 0.7;
      };
    };
  };
}
