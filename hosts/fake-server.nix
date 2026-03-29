{ config, inputs, self, pkgs, ... }:
{
  imports = [
    ../system/basic.nix
    ../system/containers.nix
    ../system/kernel-latest.nix
    ../system/nfs-client.nix
    ../system/plasma.nix
    ../system/tailscale.nix
    ../system/virtmanager.nix
    ../system/fonts.nix
    ../system/systemdboot.nix
    ../hardware/fake-server.nix
  ];
  
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.jcw = {
      imports = [
        ../home/home.nix
        ../home/bash.nix
        ../home/zsh.nix
        ../home/hm-dconf.nix
        ../home/nvim.nix
      ];
      home.stateVersion = "25.11";
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
  system.stateVersion = "24.11";
  
  networking.hostName = "fake-server";
  nixpkgs.hostPlatform = "x86_64-linux";
}
