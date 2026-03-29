{ inputs, pkgs, config, ... }:
{
  services.radarr = {
    enable = true;
    package = inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.radarr;
    user = "radarr";
    group = "users";
  };

}
