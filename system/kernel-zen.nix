{ pkgs, config, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  system.boot.loader.kernelFile = "vmlinuz";
}
