{ pkgs, config, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma5.enable = true;
  };
}
