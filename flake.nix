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
     darwinConfigurations."eikster-mbp" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/darwin/configuration.nix
        ];
     };
     homeConfigurations = {
        "eikster@eikster-mbp" = home-manager.lib.homeManagerConfiguration {
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
             ./modules/go.nix
             ./modules/lazygit.nix
             ./modules/lsd.nix
             ./modules/fzf.nix
             ./modules/gh.nix
             ./modules/git.nix
             ./modules/gpg.nix
             ./modules/pkgs.nix
             ./modules/ssh.nix
             ./modules/starship.nix
             ./modules/yubikeys.nix
             ./modules/zoxide.nix
           ];
        };
     };
  };
}
