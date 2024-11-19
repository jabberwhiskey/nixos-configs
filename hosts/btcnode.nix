{ pkgs, config, lib, ... }:
{
  imports = [
    ../system/minimal-basic.nix
    ../system/systemdboot.nix
    ../user/minimal-user.nix
  ];
}
