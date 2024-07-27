{
  pkgs,
  config,
  ...
}: {
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  environment.systemPackages = [
    pkgs.podman
    pkgs.distrobox
  ];
}
