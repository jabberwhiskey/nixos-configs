{ pkgs, config, ... }:
{
  services.transmission = {
    enable = true;
    user = "jcw";
    openFirewall = true;
    openRPCPort = true;
    settings = {
      download-dir = "/home/jcw/nas/downloads";
      rpc-whitelist = "127.0.0.1,10.0.0.1,100.103.94.88,100.91.137.34";
      rpc-bind-address = "0.0.0.0"; #Bind to own IP
    };
  };
}
