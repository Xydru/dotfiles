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

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in {
      darwinConfigurations."felix" = inputs.darwin.lib.darwinSystem {
        inherit pkgs;

        modules = [
          ./darwin.nix

          { 
            users.users."felix"  = {
              name = "felix";
              home = "/Users/felix";
              shell = pkgs.zsh;
            };
          }

          inputs.home-manager.darwinModules.home-manager {
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
