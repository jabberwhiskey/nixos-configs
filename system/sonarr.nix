{pkgs, inputs, config, ... }:
{
  services.sonarr = {
    enable = true;
    package = inputs.nixpkgs.legacyPackages.x86_64-linux.sonarr;
    openFirewall = true;
    user = "jcw";
  };
}
