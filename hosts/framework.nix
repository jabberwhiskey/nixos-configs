{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../system/basic.nix
    ../system/greetd.nix
    #../system/plasma.nix
    ../system/fonts.nix
    ../system/hyprpam.nix
    ../system/suspend.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/framework.nix
    ../system/sdr.nix
    ../system/kernel-latest.nix
  ];
  system.stateVersion = "23.05";
  home-manager.users.jcw = {
    imports = [
      ../home/home.nix
      ../home/waybar.nix
      ../home/hyprland.nix
      ../home/inhibit-hyprland.nix
    ];
    home.stateVersion = "23.05";
  };
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";
  boot.kernelParams = ["module_blacklist=hid_sensor_hub"];

#  services.fprintd.package = pkgs.fprintd.overrideAttrs {
#    mesonCheckFlags = [
#      "--no-suite"
#      "fprintd:TestPamFprintd"
#    ];
#  }; # for a failed fprintd build
  services.fprintd.enable = lib.mkForce false; #disbale fprintd becasue it fails all the time

  networking.hostName = "framework";

  environment.systemPackages = with pkgs; [
    brillo
    chezmoi
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
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
