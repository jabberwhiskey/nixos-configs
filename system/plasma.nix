{
  pkgs,
  config,
  ...
}:
{
  services.desktopManager = {
    plasma6.enable = true;
  };
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
  security.pam.services.jcw.kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };
}
