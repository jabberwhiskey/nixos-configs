{ pkgs, config, ... }:
{
#works with lpd just add ip address
  hardware.sane.brscan5 = {
    enable = true;
  };
  services.printing.enable = true;
  hardware.sane.brscan4.enable = true;
}
