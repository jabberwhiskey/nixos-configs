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
    ../system/tailscale.nix
    ../system/hyprpam.nix
#    ../system/suspend.nix
#    ../system/qt.nix
    ../system/waydroid.nix
    ../system/intel-laptop.nix
    ../system/greetd.nix
    ../system/kernel-latest.nix
#    ../system/kernel-zen.nix
#    ../system/plasma.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/hplaptop.nix
  ];
  home-manager.users.jcw = {
    programs.zsh.shellAliases = { 
      "update" = "sudo nixos-rebuild boot --flake ~/dev/nixos-configs#nixos-laptop --verbose";
      "test" = "sudo nixos-rebuild test --flake ~/dev/nixos-configs#nixos-laptop --verbose";
    };
    imports = [
      ../home/waybar.nix
      ../home/bash.nix
      ../home/nvim.nix
      ../home/zsh.nix
      ../home/hyprland.nix
      ../home/inhibit-hyprland.nix
      ../home/home.nix
    ];
    programs.foot.settings.main.font = lib.mkForce "monospace:size=12";
    home.stateVersion = "24.05";
  };
  home-manager.backupFileExtension = "backup";
  system.stateVersion = "24.05";

  networking.hostName = "nixos-laptop";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
  services.gvfs.enable = true; #for pcmanfm
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
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  nix.settings.trusted-users = [
    "jcw"
    "root"

  ];
  hardware.brillo.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  programs.dconf.enable = true;
}
