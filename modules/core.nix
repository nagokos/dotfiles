{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Cli
    atuin # history
    bottom # top
    procs # ps
    fd # find
    ripgrep # grep
    zoxide # cd with jumping
    bat # cat 
    fastfetch # system
    eza # ls
    curl

    #json
    jc
    jq
    jnv

    # Etc
    fzf

    # gui
    postman
    obsidian
    slack
    raycast
    arc-browser
  ];

  programs.starship = {
    enable = true;
  };
}
