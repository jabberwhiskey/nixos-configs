{
  pkgs,
  inputs,
  config,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  security.pam.services.jcw.kwallet = {
    forceRun = true;
    enable = true;
  };
  home-manager.users.jcw.imports = [
    ../home/hyprland.nix
    ../home/inhibit-hyprland.nix
    ../home/anyrun.nix
  ];
  environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  ];
  hardware.brillo.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
