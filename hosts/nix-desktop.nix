{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../system/basic.nix
    ../system/bt-off.nix
    ../system/systemd-tailscale.nix
#    ../system/plasma.nix
    ../system/systemdboot.nix
    ../system/tailscale.nix
    ../system/containers.nix
    ../system/virtmanager.nix
    ../hardware/desktop.nix
    ../system/hyprland.nix
    #../system/qt.nix
    ../system/bluetooth.nix
    ../system/fonts.nix
    #../system/kernel-latest.nix
    ../system/kernel-zen.nix
    ../system/greetd.nix
    ../system/steam.nix
  ];
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.jcw = {
      imports = [
        ../home/home.nix
        ../home/bash.nix
        ../home/zsh.nix
        ../home/inhibit-hyprland.nix
        ../home/waybar2.nix
        ../home/hm-dconf.nix
      ];
      home.stateVersion = "24.11";
      wayland.windowManager.hyprland = {
#      	settings.debug = { full_cm_proto=true; };
	settings.monitor = [
	  "DP-1, 2560x1440@239.95799, 0x0, 1, bitdepth, 10, cm, hdr"
          "DP-2, 3840x2160@59.99700, -170x-1080, 2"
	  "HDMI-A-1, disable"
	  ];
	  settings.bind =
	  [ "$mod Alt, F, exec, hyprctl keyword monitor HDMI-A-1, enable " 
	   "$mod Alt, G, exec, hyprctl keyword monitor HDMI-A-1, disable " ];
      };
    };
  };
  #specialArgs = { inherit inputs; };
  system.stateVersion = "24.11";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  networking.hostName = "nix-desktop";

  services.ratbagd.enable = true;

  users.users.jcw = {
    extraGroups = [
      "input"
      "dialout"
    ];
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
    bazecor
    pciutils
    g810-led
    piper
    wine
    daggerfall-unity
  ];
  hardware = {
    steam-hardware.enable = true;
  };

  boot.extraModulePackages = with config; [ pkgs.linuxPackages_zen.system76 ];
  #boot.extraModulePackages = with config; [pkgs.linuxKernel.packages.linux_6_15.system76-io];
  hardware.xone.enable = true;
  #powerManagement = {
  #  enable = true;
  #  cpuFreqGovernor = "performance";
  #};
  nixpkgs.hostPlatform = "x86_64-linux";
}
