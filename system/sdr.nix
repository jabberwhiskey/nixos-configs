{
  config,
  pkgs,
  ...
}: {
  boot.kernelParams = ["modprobe.blacklist=dvb_usb_rtl28xxu"]; # blacklist this module
  services.udev.packages = [pkgs.rtl-sdr]; # (there might be other packages that require udev here too)
  hardware.rtl-sdr.enable = true;
}
