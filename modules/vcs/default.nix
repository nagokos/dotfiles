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
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzh7sqoh2Y6x68q0eH3SiXFDZ9aJRmzXimSnL+4fHi4";
        signByDefault = true;
      };
      ignores = lib.flatten [
        "*.tmp"
        "*.swp"
        "*.log"
        ignore_mac
      ];
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
        gpg.format = "ssh";
        gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        url."git@github.com:".insteadOf = "https://github.com/";
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
      };
    };
    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "nagokos";
          email = "kosnago0428@gmail.com";
        };
        signing = {
          behavior = "own";
          backend = "ssh";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzh7sqoh2Y6x68q0eH3SiXFDZ9aJRmzXimSnL+4fHi4";
          backends.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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
      settings.git_protocol = "ssh";
      gitCredentialHelper.enable = false;
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
