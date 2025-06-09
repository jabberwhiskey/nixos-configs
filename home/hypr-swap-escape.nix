{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_options = "caps:swapescape";
    };
  };
}
