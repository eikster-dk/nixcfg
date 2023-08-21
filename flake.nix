{
  description = "eikster-dk's dotfiles written in nix";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; 

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
     darwinConfigurations."Eiks-MacBook-Pro-2" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ 
          ./modules/darwin/configuration.nix
        ];
     };
     homeConfigurations = {
        "eikchristensen@Eiks-MacBook-Pro-2" = home-manager.lib.homeManagerConfiguration {
           pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
           extraSpecialArgs = { inherit inputs; };
           modules = [ 
             ./modules/home.nix
             ./modules/wezterm/default.nix
             ./modules/git.nix
           ];
        };
     };
  };
}
