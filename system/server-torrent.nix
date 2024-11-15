{ pkgs, config, ... }:
{
  services.transmission = {
    enable = true;
    user = "jcw";
    home = "/home/jcw/nas/downloads";
    openFirewall = true;

  };
}
