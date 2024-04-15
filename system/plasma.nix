{
  pkgs,
  config,
  ...
}: {
  services.desktopManager = {
    plasma6.enable = true;
  };
  services.displayManager = {
    enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
