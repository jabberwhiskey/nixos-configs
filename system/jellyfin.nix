{ pkgs, config, ... }:
{
  services.jellyfin = {
    enable = true;
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
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver # previously vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      vpl-gpu-rt # QSV on 11th gen or newer
      intel-media-sdk # QSV up to 11th gen
    ];
  };
  users.users.jellyfin = {
    extraGroups = [ "video" "render" ];
  };
}
