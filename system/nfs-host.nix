{config, pkgs, ...}:
{
  fileSystems."/export/shared" = {
    device = "/media/nas/shared";
    options = [ "bind" ];
  };
  services.nfs.server = {
    enable = true;
    hostName = "100.85.215.105";
    exports = ''
      /export  100.105.196.3(rw,fsid=0,no_subtree_check)
      /export/shared  100.105.196.3(rw,sync,nohide,insecure,no_subtree_check) 192.168.68.0/24(rw,sync,nohide,insecure,no_subtree_check) 100.103.94.88(rw,sync,nohide,insecure,no_subtree_check) 100.99.171.95(rw,sync,nohide,insecure,no_subtree_check)
    '';
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000; 
  };
  networking.firewall = {
    allowedTCPPorts = [ 111  2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001  4002 20048 ];
  };
  boot.initrd = {
    supportedFilesystems = [ "nfs" ];
    kernelModules = [ "nfs" ];
  };
  systemd.services.nfs-server = {
    requires = [ "export-shared.mount" ];
    after = [ "multi-user.target" "rpcbind.service" ];
  };
}
