{ pkgs, comfig, lib, ... }:

{
  imports = [
    ../system/basic.nix
    ../system/greetd.nix
#    ../system/plasma.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/framework.nix
    ../system/sdr.nix
  ];
  system.stateVersion = "23.05";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";
  boot.kernelParams = ["module_blacklist=hid_sensor_hub"];
  
  services.fprintd.package = pkgs.fprintd.overrideAttrs {
    mesonCheckFlags = [
      "--no-suite"
      "fprintd:TestPamFprintd"
    ];
  }; # for a failed fprintd build

  networking.hostName = "framework";

  environment.systemPackages = with pkgs; [
    brillo
    usbutils
    pciutils
    libsForQt5.kwallet
  ];
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
  security.pam.services.swaylock = {};
#  services.xserver.displayManager.sessionPackages = with pkgs; [
#    sway
#  ];
}
