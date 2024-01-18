{
  description = "config for modular nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    stable,
    nixos-hardware,
    hyprland,
    }:{
      nixosConfigurations = {
	nixos-laptop = nixpkgs.lib.nixosSystem {
	  system = "x86_64-linux";
	  modules = [
	  ];
	};
	nixos-server = stable.lib.nixosSystem {
	  system = "x86_64-linux";
	  modules = [

	  ];
	};
	framework = nixpkgs.lib.nixosSystem {
	  system = "x86_64-linux";
	  modules = [

	  ];
	};
	nix-desktop = nixpkgs.lib.nixosSystem {
	  system = "x86_64-linux";
	  modules = [

	  ];
	};
      };
    };
  }

