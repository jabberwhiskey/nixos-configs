{ pkgs, comfig, ... }:

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

  networking.hostName = "nixos-laptop";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
  ];
#  services.xserver.displayManager.sessionPackages = with pkgs; [
#    sway
#  ];
}
