{ pkgs, config, ... }:
{
  services.transmission = {
    enable = true;
    user = "jcw";
    group = "users";
    openFirewall = true;
    openRPCPort = true;
    settings = {
      download-dir = "/media/nas/downloads";
      incomplete-dir = "/media/nas/downloads/.incomplete";
      rpc-whitelist = "127.0.0.1,10.0.0.1,100.103.94.88,100.91.137.34,100.82.251.87,100.105.196.3";
      rpc-bind-address = "0.0.0.0"; # Bind to own IP
    };
  };
}
