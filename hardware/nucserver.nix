# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d63b7b37-b8af-457d-aa9c-ee5ca3495a55";
    fsType = "btrfs";
    options = [ "compress=zstd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4552-C1D5";
    fsType = "vfat";
  };

  fileSystems."/media/nas" = {
    device = "/dev/disk/by-uuid/a80b6ac6-825d-479f-8ddf-03ff21336f13";
    fsType = "btrfs";
    options = [ "compress=zstd" "subvol=@nas" ];
  };

  fileSystems."/media/plex" = {
    device = "/dev/disk/by-uuid/04a14bf7-ecf9-4dc7-af44-8a68de787687";
    fsType = "btrfs";
    options = [ "compress=zstd" "subvol=@plex" ];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/a4411bb5-4ee9-4de2-b9e4-afa6683c87e8";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
