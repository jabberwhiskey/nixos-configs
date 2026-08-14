{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland = {
  	extraConfig = ''
    hl.config({input = { kb_options = "caps:swapescape", }, })
  	'';

  };
}
