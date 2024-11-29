{
  services.auto-cpufreq = {
    enable = true;
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "powersave";
      turbo = "auto";
    };
  };
}
