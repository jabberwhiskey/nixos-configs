{ pkgs, ... }:
{
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    libvirtd.qemu = {
      swtpm.enable = true;
    };
  };
  users.users.jcw = {
    extraGroups = [ "libvirtd" ];
    packages = [
      pkgs.virt-manager
      pkgs.virt-viewer
      pkgs.nemu
      pkgs.spice
    ];
  };
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
}
