{pkgs, config, ... }:
{
  fileSystems."/home/jcw/shared" = {
    device = "100.85.215.105:/shared";
    fsType = "nfs";
    options = [ "x-systemd.automount" "nfsvers=4.2" "noauto"  ];
  }; 
  boot.supportedFilesystems = [ "nfs" ];
  boot.kernelModules = [ "nfs" ];
  boot.initrd = {
    supportedFilesystems = [ "nfs" ];
    kernelModules = [ "nfs" ];
  };
  services.rpcbind.enable = true;
  environment.systemPackages = [ pkgs.nfs-utils ];
}
