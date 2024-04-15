{
  description = "config for modular nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stable,
    nixos-hardware,
    hyprland,
    ...
  }: {
    nixosConfigurations = {
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos-laptop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jcw = {
                imports = [
                  ./home/home.nix
                  ./home/sway.nix
                ];
                home.stateVersion = "22.11";
              };
              extraSpecialArgs = {
              };
            };
          }
        ];
      };
      #	nixos-server = stable.lib.nixosSystem {
      #	  system = "x86_64-linux";
      #	  modules = [
      #
      #	  ];
      #	};
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/framework.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jcw = {
                imports = [
                  ./home/home.nix
                  ./home/hyprland.nix
                  ./home/waybar.nix
                ];
                home.stateVersion = "23.05";
              };
            };
          }
          nixos-hardware.nixosModules.framework-11th-gen-intel
          hyprland.nixosModules.default
          {programs.hyprland.enable = true;}
        ];
      };
      nix-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nix-desktop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jcw = {
                imports = [
                  ./home/home.nix
                  ./home/hm-dconf.nix
                  ./home/waybar.nix
                ];
                home.stateVersion = "22.11";
              };
              extraSpecialArgs = {
              };
            };
          }
          {programs.hyprland.enable = true;}
        ];
      };
    };
  };
}
