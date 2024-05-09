{ pkgs, config, lib, ... }:
{
  imports = [
    ../system/basic.nix
    ../system/basic.nix
    ../system/systemdboot.nix
    ../hardware/gpdwin.nix
    ../user/user.nix
    ../system/containers.nix
  ];
}
