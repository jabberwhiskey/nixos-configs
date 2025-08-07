{ pkgs, config, lib, inputs, ... }:
{
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };
  imports = [
    ../hardware/gpd.nix
    ../user/user.nix
    ../system/kernel-latest.nix
    ../system/basic.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../system/tailscale.nix
    ../system/containers.nix
    ../system/plasma.nix
    ../system/steam.nix
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs;};
    users.jcw = {
      imports = [
        ../home/home.nix
        ../home/zsh.nix
      ];
    home.stateVersion = "23.05";
    };
  };
#  specialArgs = { inherit inputs; };
  system.stateVersion = "25.05";
  jovian.steam.autoStart = true;

  powerManagement = {
  enable = true;
  };
  networking.hostName = "gpdwin";
}
