{
  pkgs,
  lib,
  ...
}:
let
  ignore_mac = if pkgs.stdenv.isDarwin then import ./ignore_mac.nix else "";
in
{
  home.packages = with pkgs; [
    ghq
  ];
  programs = {
    git = {
      enable = true;
      ignores = lib.flatten [
        "*.tmp"
        "*.swp"
        "*.log"
        ignore_mac
      ];
      # settings = {
      # user = {
      #   name = "nagokos";
      #   email = "kosnago0428@gmail.com";
      # };
      #
      # alias = {
      #   ap = "add -p";
      #   ba = "branch -a";
      #   sw = "switch";
      #   swb = "switch -";
      #   swc = "switch -c";
      #   cm = "commit -m";
      #   fixit = "commit --amend --no-edit";
      #   st = "status";
      #   rs = "restore --staged";
      #   fe = "fetch";
      #   re = "rebase";
      #   lo = "log --oneline";
      #   po = "push origin HEAD";
      #   df = "diff";
      #   dfs = "diff --staged";
      # };
      #
      # # extraConfig
      # credential = {
      #   helper = "!gh auth git-credential";
      # };
      # init.defaultBranch = "main";
      # merge.conflictstyle = "diff3";
      # };
    };
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
        fsmonitor = {
          backend = "watchman";
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
          lo = [ "log" ];
          sp = [ "split" ];
          sq = [ "squash" ];
          sqp = [
            "squash"
            "--from"
            "@-"
          ];
          sh = [ "show" ];
          ds = [
            "describe"
            "-m"
          ];
          dsp = [
            "describe"
            "-r"
            "@-"
            "-m"
          ];
          df = [ "diff" ];
          dfp = [
            "diff"
            "-r"
            "@-"
          ];
        };
      };
    };
    gh = {
      enable = true;
      settings.git_protocol = "https";
    };
    # delta = {
    #   enable = true;
    #   enableGitIntegration = true;
    #   options = {
    #     diff-so-fancy = true;
    #     line-numbers = true;
    #     true-color = "always";
    #     side-by-side = true;
    #   };
    # };
  };
}
