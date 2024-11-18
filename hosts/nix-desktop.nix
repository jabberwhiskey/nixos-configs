{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../system/basic.nix
    ../system/systemdboot.nix
    ../system/containers.nix
    ../system/virtmanager.nix
    ../hardware/desktop.nix
    ../user/user.nix
    ../system/bluetooth.nix
    ../system/fonts.nix
#    ../system/kernel-latest.nix
    ../system/greetd.nix
    ../system/steam.nix
  ];

  home-manager.backupFileExtension = "backup";

  system.stateVersion = "23.11";
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot";

  networking.hostName = "nix-desktop";

  services.ratbagd.enable = true;

  security.pam.services.swaylock = {};
  systemd = {
    user.services.lxqt-policykit-agent = {
      description = "lxqt-policykit-agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
      };
    };
  };
  users.users.jcw = {
    extraGroups = [ "uucp" "dialout" "input" ];
  };

  environment.systemPackages = with pkgs; [
    usbutils
    gtypist
    tuxtype
    lxqt.lxqt-policykit
    bazecor
    pciutils
    g810-led
    piper
  ];
  hardware = {
    steam-hardware.enable = true;
    graphics.extraPackages = [
      pkgs.amdvlk
    ];
  };
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
