{
  description = "Home Manager configuration of andrewkong";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-darwin";
      pkgs   = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."andrewkong" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example, the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs to pass through arguments to home.nix
        extraSpecialArgs = { inputs = inputs; };
      };
    };
}
