{ pkgs, config, ... }:

{
  imports = [
    ../system/common.nix
    ../hardware/desktop.nix
    ../users/user.nix
  ];

  system.stateVersion = "23.05";
  home.stateVersion = "23.05";

  networking.hostName = "nix-desktop";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    g810-led
    piper
  ];

}
