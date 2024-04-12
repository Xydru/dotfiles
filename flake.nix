{
  description = "Home Manager configuration of felix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Controls system level software and settings including fonts
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # plugin-battery = {
    #   url = "github:justinhj/battery.nvim";
    #   flake = false;
    # };

    plugin-mini-hipatterns = {
      url = "github:echasnovski/mini.hipatterns";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: {
    darwinConfigurations."felix" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs; }; # necessary for darwin.nix to work correctly

      modules = [
        ./darwin.nix
        ./overlay.nix

        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."felix".imports = [ ./home.nix ];

            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    };
  };
}
