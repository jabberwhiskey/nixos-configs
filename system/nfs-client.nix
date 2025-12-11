{pkgs, config, ... }:
{
  fileSystems."/media/shared" = {
    device = "100.85.215.105:/shared";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "nfsvers=4.2" "noatime" "defaults" ];
  }; 
  boot.supportedFilesystems = [ "nfs" ];
  boot.initrd = {
    supportedFilesystems = [ "nfs" ];
    kernelModules = [ "nfs" ];
  };
  systemd.tmpfiles.rules = [
    "d /media/shared 0766 jcw users"
  ];
  services.rpcbind.enable = true;
  environment.systemPackages = [ pkgs.nfs-utils ];
}
