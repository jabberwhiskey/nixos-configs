{ pkgs, lib, config, ...}:
{
  boot.loader = {
    systemd.enable = lib.mkForce false;
    limine = {
      enable = true;
      secureBoot.enable = true;
    };
  };

}
