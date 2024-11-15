{
  services.jellyfin = {
    enable = true;
    group = "sonarr";
    user = "jcw";
    openFirewall = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
