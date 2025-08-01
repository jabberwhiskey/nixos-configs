{
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection = true;
    qemu = {
      swtpm.enable = true;
      ovmf.packages = [
        pkgs.OVMFFULL.fd
      ];
    };
  };
  users.users.jcw.extraGroups = [ "libvirtd" ];
}
