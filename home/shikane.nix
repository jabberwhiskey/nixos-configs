{ pkgs, config, ... }:
{
  services.shikane = {
    enable = true;
    settings = {
      profile = [
        {
          name = "laptop-output-only";
          output = [
            {
              search = "eDP-1";
              enable = true;
              mode = "1920x1080@60";
              position = "0,0";
            }
          ];
        }
        {
          name = "docked";
          output = [
            {
              search = "eDP-1";
              enable = false;
            }
            {
              search = ["s=HTKP408161" "m=U28E590" ];
              enable = true;
              mode = "3840x2160@59.994700";
              position = "0,0";

            }
          ];
        }
      ];
    };
  };
}
