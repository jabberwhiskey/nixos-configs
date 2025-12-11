{config, pkgs, ...}:
{
  fileSystems."/export/shared" = {
    device = "/media/nas/shared";
    options = [ "bind" ];
  };
  services.nfs.server = {
    enable = true;
    hostName = "nixos-server";
    exports = ''
      /export/shared  100.105.196.3(rw,sync,nohide,insecure,no_subtree_check) nix-desktop(rw,fsid=0,no_subtree_check) linainverse(rw,fsid=0,no_subtree_check) framework(rw,fsid=0,no_subtree_check)
    '';
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000; 
  };
  networking.firewall = {
    allowedTCPPorts = [ 111  2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001  4002 20048 ];
  };
}
