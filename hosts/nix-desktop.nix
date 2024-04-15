{
  pkgs,
  config,
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
  ];

  system.stateVersion = "23.05";

  networking.hostName = "nix-desktop";

  services.ratbagd.enable = true;

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    g810-led
    piper
  ];
  hardware.opengl.extraPackages = [
    pkgs.amdvlk
  ];
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
}
