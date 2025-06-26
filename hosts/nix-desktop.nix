{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../system/basic.nix
    ../system/bt-off.nix
    ../system/plasma.nix
    ../system/systemdboot.nix
    ../system/tailscale.nix
    ../system/containers.nix
    ../system/virtmanager.nix
    ../hardware/desktop.nix
    ../user/user.nix
    ../system/qt.nix
    ../system/bluetooth.nix
    ../system/fonts.nix
#    ../system/kernel-latest.nix
    ../system/kernel-zen.nix
#     ../system/greetd.nix
    ../system/steam.nix
  ];
  home-manager = {
    users.jcw = {
        imports = [
          ../home/home.nix
	  ..home/anyrun.nix
          ../home/bash.nix
          ../home/zsh.nix
          ../home/inhibit-hyprland.nix
       	  ../home/waybar2.nix
          ../home/hyprland.nix
          ../home/hm-dconf.nix
        ];
      home.stateVersion = "24.11";
      wayland.windowManager.hyprland = {
        package = null;
        portalPackage = null;
      	settings.debug = { full_cm_proto=true; };
        };
      };
     };
  system.stateVersion = "24.11";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  programs.kdeconnect.enable = true;
  networking.hostName = "nix-desktop";

  services.ratbagd.enable = true;

  users.users.jcw = {
    extraGroups = [ "uucp" "dialout" "input" ];
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.enable = true; # enables support for Bluetooth

  environment.systemPackages = with pkgs; [
    usbutils
    bazecor
    pciutils
    g810-led
    piper
    wine
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    daggerfall-unity
  ];
  hardware = {
    steam-hardware.enable = true;
    graphics.extraPackages = [
      pkgs.amdvlk
    ];
  };
  
  boot.extraModulePackages = with config; [pkgs.linuxPackages_zen.system76-io];
#  boot.extraModulePackages = with config; [pkgs.linuxKernel.packages.linux_6_15.system76-io];
  hardware.xone.enable = true;
#  powerManagement = {
#    enable = true;
#    cpuFreqGovernor = "performance";
#  };
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  nixpkgs.hostPlatform = "x86_64-linux";
}
