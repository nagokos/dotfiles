{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Mac
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust toolchain
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      neovim-nightly-overlay,
      fenix,
      nur,
      ...
    }@inputs:
    let
      home-common =
        { lib, ... }:
        {
          nixpkgs.overlays = [
            neovim-nightly-overlay.overlays.default
            fenix.overlays.default
            nur.overlays.default
          ];

          nixpkgs.config.allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "1password-cli"
            ];

          programs.home-manager.enable = true;
          home.stateVersion = "25.11";
          imports = [
            ./modules/core.nix
            ./modules/direnv
            ./modules/nu
            ./modules/zsh
            ./modules/nvim
            ./modules/starship
            # ./modules/yazi
            ./modules/atuin
            ./modules/vcs
          ];
        };
      home-macbook = {
        home.username = "kosudanaohiro";
        home.homeDirectory = "/Users/kosudanaohiro";
      };
    in
    {
      homeConfigurations = {
        x86_64-mac = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-darwin";
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            home-macbook
            home-common
          ];
        };
        aarch64-mac = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            home-macbook
            home-common
          ];
        };
      };
      darwinConfigurations = {
        x86_64-darwin = nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./darwin/homebrew.nix
            ./darwin/configuration.nix
          ];
        };
        aarch64-darwin = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./darwin/homebrew.nix
            ./darwin/configuration.nix
          ];
        };
      };
    };
}
