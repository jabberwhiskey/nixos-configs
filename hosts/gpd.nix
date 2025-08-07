{ pkgs, config, lib, inputs, ... }:
{
  config = {
    nixpkgs = {
      hostPlatform = "x86_64-linux";
    };
    imports = [
      ../hardware/gpd.nix
      ../user/user.nix
      ../system/basic.nix
      ../system/containers.nix
      ../system/plasma.nix
      ../system/steam.nix
    ];
    home-manager = {
      users.jcw = {
        imports = [
          ..home/home.nix
        ];
      };
    };
    jovian.steam.autoStart = true;

  };
}
