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

    plugin-battery = {
      url = "github:justinhj/battery.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
    let
      # system = "aarch64-darwin";
      # pkgs = import nixpkgs { inherit system; };
    in {
      darwinConfigurations."felix" = darwin.lib.darwinSystem {
        # inherit pkgs;
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };

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
