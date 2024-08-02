{
  description = "config for modular nixos systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stable,
    nixos-hardware,
    hyprland,
    wayland-pipewire-idle-inhibit,
    ...
  }: {
    nixosConfigurations = {
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos-laptop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jcw = {
	        services.wayland-pipewire-idle-inhibit = {
                  enable = true;
                  systemdTarget = "hyprland-session.target";
                  settings = {
                    verbosity = "INFO";
                    media_minimum_duration = 10;
                    idle_inhibitor = "wayland";
                    sink_whitelist = [
                    ];
                  };
                };
                imports = [
		  inputs.wayland-pipewire-idle-inhibit.homeModules.default
                  ./home/home.nix
		  ./home/hyprland.nix
#                  ./home/sway.nix
                ];
                home.stateVersion = "22.11";
              };
              extraSpecialArgs = {
	        inherit inputs; 
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
                services.wayland-pipewire-idle-inhibit = {
                  enable = true;
                  systemdTarget = "hyprland-session.target";
                  settings = {
                    verbosity = "INFO";
                    media_minimum_duration = 10;
                    idle_inhibitor = "wayland";
                    sink_whitelist = [
                    ];
                  };
                };
                imports = [
                  ./home/home.nix
		  inputs.wayland-pipewire-idle-inhibit.homeModules.default
                  ./home/hyprland.nix
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
                services.wayland-pipewire-idle-inhibit = {
                  enable = true;
                  systemdTarget = "hyprland-session.target";
                  settings = {
                    verbosity = "INFO";
                    media_minimum_duration = 10;
                    idle_inhibitor = "wayland";
                  };
		};
                imports = [
                  ./home/home.nix
		  inputs.wayland-pipewire-idle-inhibit.homeModules.default
		  ./home/hyprland.nix
                  ./home/hm-dconf.nix
                ];
                home.stateVersion = "23.11";
              };
              extraSpecialArgs = {
              };
            };
          }
          hyprland.nixosModules.default
          {programs.hyprland.enable = true;}
        ];
      };
#      gpdwin = stable.lib.nixosSystem {
#        system = "x86_64-linux";
#	modules = [
#          ./hosts/gpdwin.nix
#	  home-manager.nixosModules.home-manager
#	  {
#            home-manager = {
#              useGlobalPkgs = true;
#	      useUserPackages = true;
#	      users.jcw = {
#                imports = [
#                  ./home/home.nix
#		];
#	      home.stateVersion = "23.11";
#	      };
#	    };
#	  }
#	];
#      };
    };
  };
}
