{ config, pkgs, lib, ...}:
{
  home = {
    file = {
      ".config/hypr/hyprland.config".source = config.lib.file.mkOutOfStoreSymlink ../extra/laptopHyprland.conf;
    };
  };
}
