{ pkgs, ... }:
let
  mmemoSrc = pkgs.fetchFromGitHub {
    owner = "nagokos";
    repo = "mmemo";
    rev = "c43bf95b2cad03386d2ec7bfbb0c871b5fbf4489";
    hash = "sha256-NCuNqYgExynpZ3YnjO73jC9KwvDp+4k6iMGDQPoyFi8=";
  };

  mmemo = pkgs.rustPlatform.buildRustPackage {
    pname = "mmemo";
    version = "0.1.0";
    src = mmemoSrc;

    cargoLock.lockFile = "${mmemoSrc}/Cargo.lock";

    buildInputs = pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.libiconv ];

    meta.mainProgram = "mmemo";
  };
in
{
  home.packages = with pkgs; [
    #######################
    ## Cli
    bottom # top
    procs # ps
    fd # find
    ripgrep # grep
    zoxide # cd with jumping
    bat # cat
    fastfetch # system
    eza # ls
    curl # http
    xh # http
    nurl # nix
    mmemo # memo tool

    #json
    jc
    jq
    jnv

    # Etc
    fzf
    zstd
    imagemagick
    fish

    #################
    ## programming
    docker

    # C
    # Disabled on macOS due to Rust compilation linker conflicts / Required for Linux only
    # gcc

    # Go
    go

    # Haskell
    haskellPackages.ghc
    haskellPackages.cabal-install
    haskellPackages.hoogle

    # Lua
    lua

    # JS/TS
    nodejs_20
    pnpm

    # Rust
    #(fenix.combine [
    #  fenix.stable.toolchain
    #  fenix.targets.wasm32-unknown-unknown.stable.rust-std
    #  fenix.targets.wasm32-wasi.stable.rust-std
    #])
    fenix.latest.toolchain
    # repl
    evcxr

    # etc
    typos

    ###########################
    ## Fonts
    nerd-fonts.jetbrains-mono

    ###################
    ## gui
    obsidian
    slack
    discord
    zoom-us
  ];
}
