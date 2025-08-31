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
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
=======
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
>>>>>>> e1d11bc (cleaned up config)
  };
  security.pam.services.jcw.kwallet = {
    forceRun = true;
    enable = true;
<<<<<<< HEAD
=======
    package = pkgs.kdePackages.kwallet;
>>>>>>> e1d11bc (cleaned up config)
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
