{ pkgs, ... }:
{
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    libvirtd.qemu = {
      swtpm.enable = true;
      ovmf.packages = [
        pkgs.OVMFFull.fd
      ];
    };
  };
  users.users.jcw = {
    extraGroups = [ "libvirtd" ];
    packages = [ 
      pkgs.virt-manager
      pkgs.nemu
      ];
  };
}
