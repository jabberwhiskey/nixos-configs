{pkgs, config, ... }:
{
  fileSystems."/media/shared" = {
    device = "nixos-server:/export/shared";
    fstype = "nfs";
  }; 
}
