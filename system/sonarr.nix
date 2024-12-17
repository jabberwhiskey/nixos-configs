{pkgs, inputs, config, ... }:
let 
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-runtime-wrapped-6.0.36"
    "dotnet-runtime-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];
in {
  services.sonarr = {
    enable = true;
#    package = inputs.nixpkgs.legacyPackages.x86_64-linux.sonarr;
    openFirewall = true;
    user = "jcw";
  };
}
