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
    ../system/kernel-latest.nix
    ../system/greetd.nix
    ../system/steam.nix
  ];
  home-manager = {
    users.jcw = {
        imports = [
          ../home/home.nix
          ../home/inhibit-hyprland.nix
          ../home/hyprland.nix
          ../home/hm-dconf.nix
        ];
        home.stateVersion = "23.11";
    };
    backupFileExtension = "backup";
    };

  system.stateVersion = "23.11";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  networking.hostName = "nix-desktop";

  services.ratbagd.enable = true;

  users.users.jcw = {
    extraGroups = [ "uucp" "dialout" "input" ];
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.enable = true; # enables support for Bluetooth

  environment.systemPackages = with pkgs; [
    usbutils
    gtypist
    tuxtype
    lxqt.lxqt-policykit
    bazecor
    pciutils
    g810-led
    piper
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
  hardware = {
    steam-hardware.enable = true;
    graphics.extraPackages = [
      pkgs.amdvlk
    ];
  };
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
}
