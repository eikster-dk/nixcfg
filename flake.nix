{
  description = "eikster-dk's dotfiles written in nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # flake.parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    ghostty.url = "github:ghostty-org/ghostty";

    # Nix-darwin
    nix-darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    # tailscale
    tailscale.url = "https://flakehub.com/f/tailscale/tailscale/1.76.6.tar.gz";

    # Theming
    stylix.url = "github:danth/stylix/release-25.05";
    catppuccin.url = "github:catppuccin/nix";

    #secure boot
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { self
    , nixpkgs
    , home-manager
    , nix-darwin
    , catppuccin
    , determinate
    , flake-parts
    , ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      flake = {
        # If I one day require overlays, then it's here:
        # overlays = import ./modules/overlays { inherit inputs; };

        # my nixos modules
        nixosModules = {
          eikster = import ./modules/hosts/nixos.nix;
          server = import ./modules/server/nixos.nix;
        };

        # my darwin modules
        darwinModules = {
          eikster = import ./modules/hosts/darwin.nix;
        };

        # my home-manager modules
        homeMangerModules = {
          eikster = import ./modules/home-manager;
        };

        # nixos
        nixosConfigurations = {
          bytestorm = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };
            modules = [ ./hosts/bytestorm ];
          };
          mibzy = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };
            modules = [ ./hosts/mibzy ];
          };
        };

        # darwin
        darwinConfigurations = {
          "eikster-mbp" = nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit inputs;
            };
            system = "aarch64-darwin";
            modules = [
              determinate.darwinModules.default
              ./hosts/mbp-private/darwin.nix
            ];
          };
          "eikster-ftg" = nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit inputs;
            };
            system = "aarch64-darwin";
            modules = [
              ./hosts/mbp-work/darwin.nix
            ];
          };
        };

        # home-manager
        homeConfigurations = {
          "eikster@eikster-mbp" = home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
            extraSpecialArgs = { inherit inputs; };
            modules = [
              catppuccin.homeModules.catppuccin
              ./users/eikster/home
            ];
          };
          "eikftg@eikster-ftg" = home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
            extraSpecialArgs = { inherit inputs; };
            modules = [
              catppuccin.homeModules.catppuccin
              ./users/eikftg/home
            ];
          };
        };
      };
    };
}
