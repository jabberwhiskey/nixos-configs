{ config, pkgs, lib, ...}:
{
  home = {
   # xdg.configFile."hyprland".source = "${dotfiles}/hypr/hyprland";
    packages = with pkgs; [
      wofi
      alacritty
      ranger
      swaylock-effects
    ];
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
      {timeout = 300; command = "${pkgs.swaylock}/bin/swaylock --screenshots --clock --indicator indicator-radius 100 --indicator-thickness 7 --effect-vifnette 0.5:0.5 --effect-blur 7x5 --ringcolor bb00cc --grace 4 --fade-in 0.3 ";}
      {timeout = 600; command = "${pkgs.systemd}/bin/systemctl suspend";}
    ];

  };
  programs.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = "/home/jcw/Pictures/wallpapers/framework";
        sorting = "descending";
      };
    };
  };
}
