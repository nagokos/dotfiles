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
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
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
            inputs.neovim-nightly-overlay.overlays.default
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
          ];
        };
      home-macbook = {
        home.username = "naohirokosuda";
        home.homeDirectory = "/Users/naohirokosuda";
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
        nagokos = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-darwin";
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            home-macbook
            home-common
          ];
        };
      };
      darwinConfigurations."Naohiro" = darwin.lib.darwinSystem {
        pkgs = nixpkgs.legacyPackages."x86_64-darwin";
        modules = [
          ./darwin/homebrew.nix
          ./darwin/configutation.nix
        ];
      };
      # formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixfmt-rfc-style;
    };
}
