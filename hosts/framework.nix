{ pkgs, comfig, lib, ... }:

{
  imports = [
    ../system/basic.nix
    ../system/plasma.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/framework.nix
    ../system/sdr.nix
  ];
  system.stateVersion = "23.05";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  networking.hostName = "framework";
#  networking.wireless.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
  ];
#  services.xserver.displayManager.sessionPackages = with pkgs; [
#    sway
#  ];
}
