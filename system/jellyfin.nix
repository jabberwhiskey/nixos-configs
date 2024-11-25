{ pkgs, inputs, config, lib, ... }:
{
  users.users.jellyfin.group = "users";
  users.users.jellyfin.isSystemUser = true;

  services.jellyfin = {
    enable = true;
    package = inputs.nixpkgs.legacyPackages.x86_64-linux.jellyfin;
    group = "users";
    user = "jcw";
    openFirewall = true;
  };
#  environment.systemPackages = [
#    pkgs.jellyfin
#    pkgs.jellyfin-web
#    pkgs.jellyfin-ffmpeg
#    pkgs.ffmpeg
#  ];
  nixpkgs.config.packageOverrides = pkgs: {
  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = { #for 24.05 and earlier
#  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.intel-vaapi-driver # previously vaapiIntel
      pkgs.vaapiVdpau
      pkgs.libvdpau-va-gl
#      inputs.old-stable.legacyPackages.x86_64-linux.intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      pkgs.intel-compute-runtime
#      hpl-gpu-rt # QSV on 11th gen or newer
      pkgs.intel-media-sdk # QSV up to 11th gen
    ];
  };
  systemd.services.jellyfin.serviceConfig.PrivateDevices = lib.mkForce false;
  users.users.jellyfin = {
    extraGroups = [ "video" "render" ];
  };
}
