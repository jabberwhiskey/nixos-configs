{pkgs, config, ... }:
{
  fileSysytems."/media/shared" = {
    device = "nixos-server:/export/shared";
    fstype = "nfs";
  }; 
}
