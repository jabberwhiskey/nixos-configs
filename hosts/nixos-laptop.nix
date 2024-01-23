{ pkgs, comfig, ... }:

{
  imports = [
    ../system/basic.nix
    ../system/plasma.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/hplaptop.nix
  ];
  system.stateVersion = "22.11";
  
  networking.hostName = "nixos-laptop";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
  ];
}
