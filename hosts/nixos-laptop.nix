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
    ../system/greetd.nix
    ../system/kernel-latest.nix
#    ../system/plasma.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../user/user.nix
    ../hardware/hplaptop.nix
  ];
  home-manager.users.jcw = {
    imports = [
      ../home/waybar.nix
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
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
     governor = "powersave";
     turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };


  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
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
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  hardware.brillo.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
