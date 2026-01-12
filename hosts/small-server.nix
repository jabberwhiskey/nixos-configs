{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../hardware/small-server.nix
    ../system/nixBitcoin.nix
    ../user/minimal-user.nix
    ../system/minimal-basic.nix
    ../system/tailscale.nix
    ../system/systemdboot.nix
  ];
  users.users.jcw.openssh.authorizedKeys.keyFiles = [
    ../user/keys
  ];
  system.stateVersion = "24.11";
  networking.hostName = "small-server";
  services.tailscale.useRoutingFeatures = "both";
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      #      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };
  environment.systemPackages = with pkgs; [
    mc
    htop
  ];
  nix.settings.trusted-users = [
    "jcw"
  ];
  boot.loader.efi.efiSysMountPoint = lib.mkForce "/boot/efi";
  users.users.jcw = {
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };
  nixpkgs.hostPlatform = "x86_64-linux";
  documentation.enable = false;
}
