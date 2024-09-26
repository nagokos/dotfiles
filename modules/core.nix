{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #######################
    ## Cli
    atuin # history
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

    #json
    jc
    jq
    jnv

    # Etc
    fzf

    #################
    ## programming
    docker

    # C
    gcc

    # Go
    go

    # JS/TS
    nodejs_20
    pnpm

    # Rust
    (fenix.combine [
      fenix.stable.toolchain
      fenix.targets.wasm32-unknown-unknown.stable.rust-std
      fenix.targets.wasm32-wasi.stable.rust-std
    ])

    ###########################
    ## Fonts
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })

    ###################
    ## gui
    obsidian
    slack
    discord
    zoom-us
  ];
}
