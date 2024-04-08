{ config, pkgs, lib, ...}:
{
  home = {
   # xdg.configFile."hyprland".source = "${dotfiles}/hypr/hyprland";
    packages = with pkgs; [
      wofi
      alacritty
    ];
  };
}
