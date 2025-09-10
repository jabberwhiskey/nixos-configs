#A common config needed for all (my) nixos systems
{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ../user/minimal-user.nix
  ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "US/Mountain";

  networking.networkmanager.enable = true;

  services.fwupd.enable = true;
  services.openssh = {
    enable = true;
    openFirewall = lib.mkForce false;
    settings = {
      PasswordAuthentication = false;
      #      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };
  networking.firewall = {
    enable = true;
    #    allowedTCPPorts = [ 80 9091 51413];
    trustedInterfaces = [ "tailscale0" ];
  };
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    tmux
  ];
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    settings.trusted-users = [ "jcw" ];
  };
}
