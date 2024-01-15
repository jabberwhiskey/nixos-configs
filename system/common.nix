#A common config needed for all (my) nixos systems
{ pkgs, config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "US/Mountain";

  services.xserver = {
    layout = "us"
    xkbVarient = "";
  };

}
