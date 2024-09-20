{ config, pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      LANG = "ja_JP.UTF-8";
      STARSHIP_CONFIG = "/Users/naohirokosuda/modules/zsh/starship.toml";
    };
    # PATH の設定
    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 10000;
      save = 10000;
    };
    initExtra = ''
            # atuin
            eval "$(atuin init zsh)"

            #zoxide
            eval "$(zoxide init zsh)"

            # starship
            eval "$(starship init zsh)"

            # fzfのデフォルト設定
            export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border \
            --preview-window 'right:50%' \
            --bind 'ctrl-/:change-preview-window(80%|hidden|)' \
            --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'"

      			bindkey '^P' up-line-or-history
      bindkey '^N' down-line-or-history

            function change-git-directory-with-incremental-search () {
            local WORKDIR=$(${pkgs.ghq}/bin/ghq list -p | ${pkgs.fzf}/bin/fzf --preview "${pkgs.onefetch}/bin/onefetch --show-logo never {}" --preview-window=right,50% --height 70%)
            [ -z "$WORKDIR" ] && return
            cd $WORKDIR
            }
    '';
    shellAliases = {
      dc = "docker compose";
      cat = "bat";
      cd = "z";
      ps = "procs";
      grep = "rg";
      find = "fd";
      ls = "eza --icons";
      sed = "gsed";
      vi = "nvim";
      vim = "nvim";
      lgit = "lazygit";
      bls = "brew list";
      bin = "brew install";
      bui = "brew uninstall";
      bup = "brew upgrade && brew upgrade --cask --greedy";
      crun = "cargo run";
      fg = "change-git-directory-with-incremental-search";
    };
  };
}
