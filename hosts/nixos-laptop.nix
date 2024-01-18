{ pkgs, comfig, ... }:

{
  imports = [
    ../system/common.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../users/user.nix
    ../hardware/hplaptop.nix
  ];
  system.stateVersion = "22.11";
  
  networking.hostname = "nixos-laptop";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
  ];
}
