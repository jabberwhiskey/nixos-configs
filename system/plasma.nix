{ pkgs, config, ... }:
{
  services.desktopManager= {
    plasma6.enable = true;
  };
  services.xserver = {
    enable=true;
    displayManager = {
      sddm = {
        enable = true;
	wayland.enable = true;
      };
    };
  };
  
}
