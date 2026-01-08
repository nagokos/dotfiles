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
      settings = {
        user = {
          name = "nagokos";
          email = "kosnago0428@gmail.com";
        };

        alias = {
          ap = "add -p";
          ba = "branch -a";
          sw = "switch";
          swb = "switch -";
          swc = "switch -c";
          cm = "commit -m";
          fixit = "commit --amend --no-edit";
          st = "status";
          rs = "restore --staged";
          fe = "fetch";
          re = "rebase";
          lo = "log --oneline";
          po = "push origin HEAD";
          df = "diff";
          dfs = "diff --staged";
        };

        # extraConfig
        credential = {
          helper = "!gh auth git-credential";
        };
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
      };

      ignores = lib.flatten [
        "*.tmp"
        "*.swp"
        "*.log"
        gitignore_global
      ];

    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
        side-by-side = true;
      };
    };

    gh = {
      enable = true;
      settings.git_protocol = "https";
    };
  };
}
