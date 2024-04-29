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
    ../system/steam.nix
  ];

  system.stateVersion = "23.11";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  networking.hostName = "nix-desktop";

  services.ratbagd.enable = true;

  security.pam.services.swaylock = {};

  environment.systemPackages = with pkgs; [
    usbutils
    bazecor
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
