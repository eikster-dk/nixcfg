{
  description = "eikster-dk's dotfiles written in nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # flake.parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    ghostty.url = "github:ghostty-org/ghostty";

    # Nix-darwin
    nix-darwin.url = "github:lnl7/nix-darwin";
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
    catppuccin.url = "github:catppuccin/nix";
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
          mibzy = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };
            modules = [ ./hosts/mibzy ];
          };
          nixbook = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };
            modules = [ ./hosts/nixbook ];
          };
        };

        # darwin
        darwinConfigurations = {
          "eikster-mbp" = nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit inputs;
            };
            system = "aarch64-darwin";
            modules = [ ./hosts/mbp-private/darwin.nix ];
          };
          work = nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit inputs;
            };
            system = "aarch64-darwin";
            modules = [ ./hosts/mbp-work ];
          };
        };

        # home-manager
        homeConfigurations = {
          "eikster@eikster-mbp" = home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
            extraSpecialArgs = { inherit inputs; };
            modules = [
              catppuccin.homeManagerModules.catppuccin
              ./users/eikster/home
            ];
          };
          # "eikftg@hostname" = home-manager.lib.homeManagerConfiguration {
          #   pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
          #   extraSpecialArgs = { inherit inputs; };
          #   modules = [
          #     catppuccin.homeManagerModules.catppuccin
          #     ./users/eikftg/home.nix
          #   ];
          # };
        };
      };
    };
}
