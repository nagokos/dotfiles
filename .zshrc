# mise
eval "$(mise activate zsh)"
# atuin
eval "$(atuin init zsh)"
# zsh plugin manager
eval "$(sheldon source)"
# starship
eval "$(starship init zsh)"

# 1password 
source /Users/naohirokosuda/.op/plugins.sh

# alias
alias dc="docker compose"
alias cat="bat"
alias ps="procs"
alias grep="rg"
alias find="fd"
alias ls="eza --icons"
alias sed="gsed"
alias vi="nvim"
alias vim="nvim"
alias lgit="lazygit"
alias bls="brew list"
alias bin="brew install"
alias bui="brew uninstall"
alias bup="brew upgrade && brew upgrade --cask --greedy"
alias crun="cargo run"
alias fg="change-git-directory-with-incremental-search"

# fzfのデフォルト設定
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border \
--preview-window 'right:50%' \
--bind 'ctrl-/:change-preview-window(80%|hidden|)' \
--bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'"

function change-git-directory-with-incremental-search () {
  local WORKDIR=$(ghq list -p | fzf --preview "onefetch --show-logo never {}" --preview-window=right,50% --height 70%)
  [ -z "$WORKDIR" ] && return
  cd $WORKDIR
}
