{
  pkgs,
  lib,
  ...
}:
let
  gitignore_global = if pkgs.stdenv.isDarwin then import ./gitignore_mac.nix else "";
in
{
  programs = {
    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "nagokos";
          email = "kosnago0428@gmail.com";
        };
        ui = {
          editor = "nvim";
        };
        core = {
          fsmonitor = "watchman";
          gitignore = lib.flatten [
            "*.tmp"
            "*.swp"
            "*.log"
            gitignore_global
          ];
        };
        aliases = {
          tug = [
            "bookmark"
            "move"
            "--from"
            "heads(::@- & bookmarks())"
            "--to"
            "@-"
          ];
        };
      };
    };
  };
}
