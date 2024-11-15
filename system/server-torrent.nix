{ pkgs, config, ... }:
{
  services.transmission = {
    enable = true;
    user = "jcw";
    openFirewall = true;
    settings = {
      download-dir = "home/jcw/nas/downloads";
    };
  };
}
