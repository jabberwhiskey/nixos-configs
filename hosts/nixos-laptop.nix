{ pkgs, comfig, lib, ... }:

{
  imports = [
    ../system/basic.nix
    ../system/kernel-latest.nix
    ../system/plasma.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/hplaptop.nix
  ];
  system.stateVersion = "22.11";
  
  networking.hostName = "nixos-laptop";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
  ];
  programs.sway.enable = true;
}
