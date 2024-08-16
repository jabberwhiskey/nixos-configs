{
  pkgs,
  config,
  lib,
  inputs,
  hyprland,
  ...
}: {
  imports = [
    ../system/basic.nix
    ../system/u2f.nix
    ../system/hyprpam.nix
    ../system/suspend.nix
#    ../system/qt.nix
    ../system/waydroid.nix
    ../system/greetd.nix
#    ../system/kernel-latest.nix
#    ../system/plasma.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/hplaptop.nix
  ];
  system.stateVersion = "24.05";

  networking.hostName = "nixos-laptop";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
  ];
#  programs.sway ={
#    enable = true;
#    extraPackages = with pkgs; [
#      swaylock-effects
#      swayidle
#      wofi
#      i3status-rust
#      grim 
#      slurp
#      ranger
#    ];
#  };
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
}
