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
      /export/shared  nixos-laptop(rw,fsid=0,no_subtree_check) nix-desktop(rw,fsid=0,no_subtree_check) linainverse(rw,fsid=0,no_subtree_check) framework(rw,fsid=0,no_subtree_check)
    '';
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000; 
  };
}
