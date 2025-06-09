{ pkgs, config, ... }:
{
  home.wayland.windowManager.hyprland.settings = {
    input = {
      kb_options = "caps:swapescape";
    };
  };
}
