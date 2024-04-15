{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ../system/basic.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../system/virtmanager.nix
    ../hardware/desktop.nix
    ../user/user.nix
    ../system/bluetooth.nix
    ../system/fonts.nix
    ../system/kernel-latest.nix
    ../system/greetd.nix
  ];

  system.stateVersion = "23.05";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi"

  networking.hostName = "nix-desktop";
  networking.networkmanager.enable = lib.mkForce false;

  services.ratbagd.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    g810-led
    piper
  ];
  hardware.opengl.extraPackages = [
    pkgs.amdvlk
  ];
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
}
