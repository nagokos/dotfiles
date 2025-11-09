{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    # Mac
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## BUG: https://github.com/hraban/mac-app-util/issues/39
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      ## inputs.nixpkgs.follows = "nixpkgs";
      inputs.cl-nix-lite.url = "github:r4v3n6101/cl-nix-lite/url-fix";
    };

    # Neovim
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

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
      darwin,
      neovim-nightly-overlay,
      fenix,
      ...
    }@inputs:
    let
      home-common =
        { lib, ... }:
        {
          nixpkgs.config.allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "slack"
              "obsidian"
              "raycast"
              "discord"
              "zoom"
            ];

          nixpkgs.overlays = [
            neovim-nightly-overlay.overlays.default
            fenix.overlays.default
          ];

          programs.home-manager.enable = true;
          home.stateVersion = "24.11";
          imports = [
            ./modules/core.nix
            ./modules/git
            ./modules/direnv
            ./modules/nu
            ./modules/zsh
            ./modules/nvim
            ./modules/raycast
            ./modules/starship
            ./modules/yazi
            ./modules/wezterm
            ./modules/atuin
          ];
        };
      home-macbook = {
        home.username = "kosudanaohiro";
        home.homeDirectory = "/Users/kosudanaohiro";
        imports = [
          inputs.mac-app-util.homeManagerModules.default
        ];
        xdg.configFile."nix/nix.conf".text = ''
          experimental-features = nix-command flakes
        '';
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
        x86_64-apple-darwin = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./darwin/homebrew.nix
            ./darwin/configutation.nix
          ];
        };
        aarch64-darwin = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./darwin/homebrew.nix
            ./darwin/configutation.nix
          ];
        };
      };
    };
}
