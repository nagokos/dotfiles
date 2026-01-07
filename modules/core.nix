{ pkgs, ... }:
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
    jujutsu

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
