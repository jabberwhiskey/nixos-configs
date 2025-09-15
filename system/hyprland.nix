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
<<<<<<< HEAD
<<<<<<< HEAD
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
=======
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
>>>>>>> e1d11bc (cleaned up config)
=======
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
  };
  security.pam.services.jcw.kwallet = {
    forceRun = true;
    enable = true;
<<<<<<< HEAD
<<<<<<< HEAD
=======
    package = pkgs.kdePackages.kwallet;
>>>>>>> e1d11bc (cleaned up config)
=======
>>>>>>> 6f9a7b7 (updated lockfile fixed rofi)
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
