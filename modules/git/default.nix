{
  pkgs,
  lib,
  ...
}:
let
  gitignore_global = if pkgs.stdenv.isDarwin then import ./gitignore_mac.nix else "";
in
{
  home.packages = with pkgs; [
    ghq
  ];
  programs = {
    git = {
      enable = true;
      userName = "naohiro kosuda";
      userEmail = "kosnago0428@gmail.com";

      delta = {
        enable = true;
        options = {
          features = "side-by-side line-numbers decorations";
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-style = "bold yellow";
            file-decoration-style = "none";
          };
        };
      };

      aliases = {
        ap = "add - p";
        ba = "branch -a";
        s = "switch";
        sm = "switch -";
        sc = "switch -c";
        cm = "commit -m";
        fixit = "commit --amend --no-edit";
        st = "status";
        f = "fetch";
        r = "rebase";
        lo = "log --oneline";
        po = "push origin HEAD";
        df = "diff";
        dfs = "diff --staged";
      };

      ignores = lib.flatten [
        "*.tmp"
        "*.swp"
        "*.log"
        gitignore_global
      ];

      extraConfig = {
        init.defaultBranch = "main";
        merge.confilictstyle = "diff3";
      };
    };

    gh = {
      enable = true;
      settings.git_protocol = "https";
    };
  };
}
