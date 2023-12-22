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
             ./modules/fish
             ./modules/k9s
             ./modules/neovim
             ./modules/wezterm/default.nix
             ./modules/tmux
             ./modules/home.nix
             ./modules/bat.nix
             ./modules/direnv.nix
             ./modules/editorconfig.nix
             ./modules/lsd.nix
             ./modules/fzf.nix
             ./modules/gh.nix
             ./modules/git.nix
             ./modules/pkgs.nix
             ./modules/starship.nix
             ./modules/zoxide.nix
           ];
        };
     };
  };
}
