{ pkgs, config, ... }:

{
  imports = [
    ../system/common.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../system/virtmanager.nix
    ../hardware/desktop.nix
    ../users/user.nix
    ../system/bluetooth.nix
  ];

  system.stateVersion = "23.05";
  home.stateVersion = "23.05";

  networking.hostName = "nix-desktop";

  services.ratbagd.enable = true;


  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    g810-led
    piper
  ];
  hardware.opengl.extreaPackages = [
    pkgs.amdvlk
  ];
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance"
  };

}
