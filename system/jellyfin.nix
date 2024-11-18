{ pkgs, inputs, config, lib, ... }:
{
  services.jellyfin = {
    enable = true;
    package = inputs.nixpkgs.legacyPackages.x86_64-linux.jellyfin;
#    group = "sonarr";
#    user = "jcw";
    openFirewall = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
  nixpkgs.config.packageOverrides = pkgs: {
  vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver # previously vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      #hpl-gpu-rt # QSV on 11th gen or newer
      intel-media-sdk # QSV up to 11th gen
    ];
  };
  systemd.services.jellyfin.serviceConfig.PrivateDevices = lib.mkForce false;
  users.users.jellyfin = {
    extraGroups = [ "video" "render" ];
  };
}
