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
#    ../system/plasma.nix
    ../system/systemdboot.nix
    ../system/tailscale.nix
    ../system/containers.nix
    ../system/virtmanager.nix
    ../hardware/desktop.nix
    ../user/user.nix
    ../system/bluetooth.nix
    ../system/fonts.nix
#    ../system/kernel-latest.nix
    ../system/kernel-zen.nix
    ../system/greetd.nix
    ../system/steam.nix
  ];
  home-manager = {
    users.jcw = {
        imports = [
          ../home/home.nix
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
	};
    };
    backupFileExtension = "backup";
    };

  system.stateVersion = "24.11";
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  networking.hostName = "nix-desktop";
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
#      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };

  services.ratbagd.enable = true;

  users.users.jcw = {
    extraGroups = [ "uucp" "dialout" "input" ];
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.enable = true; # enables support for Bluetooth

  environment.systemPackages = with pkgs; [
    usbutils
    lxqt.lxqt-policykit
    bazecor
    pciutils
    g810-led
    piper
    wine
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
  hardware = {
    steam-hardware.enable = true;
    graphics.extraPackages = [
      pkgs.amdvlk
    ];
  };
  
  boot.extraModulePackages = with config; [pkgs.linuxPackages_zen.system76];
  hardware.xone.enable = true;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  nixpkgs.hostPlatform = "x86_64-linux";
}
