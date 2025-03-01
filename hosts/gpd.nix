{ pkgs, config, lib, ... }:
{
  config = {
    nixpkgs = {
      hostPlatform = "x86_64-linux";
    };
    imports = [
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

  };
}
