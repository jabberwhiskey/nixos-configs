{ pkgs, config, ... }:
{
  services.auto-cpufreq = {
    enable = true;
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
  services.thermald.enable = true;
}
