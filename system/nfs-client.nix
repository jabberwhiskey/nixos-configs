{pkgs, config, ... }:
{
  systemd.mounts = [{
      enable = true;
      what = "100.85.215.105:/shared";
      where = "/home/jcw/shared";
      options = "user,rw,_netdev,nfsvers=4.2";
      after = ["tailscaled.service"];
      type = "nfs";
      name = "home-jcw-shared.mount";
      mountConfig = {
        TimeoutSec = 10;
        LazyUnmount = true;
      };
  }];
  systemd.automounts = [
    {
      name = "home-jcw-shared.automount";
      enable = true;
      where = "/home/jcw/shared";
      wantedBy = [ "multi-user.target" ];
    }
  ];
  boot.supportedFilesystems = [ "nfs" ];
  boot.kernelModules = [ "nfs" ];
  boot.initrd = {
    supportedFilesystems = [ "nfs" ];
    kernelModules = [ "nfs" ];
  };
  services.rpcbind.enable = true;
  environment.systemPackages = [ pkgs.nfs-utils ];
}
