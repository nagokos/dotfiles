# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# starship
eval "$(starship init zsh)"
# mise
eval "$(mise activate zsh)"
# コマンド履歴の管理

# 1password 
source /Users/naohirokosuda/.op/plugins.sh

# alias
alias dc="docker compose"
alias cat="bat"
alias ps="procs"
alias grep="rg"
alias find="fd"
alias ls="eza"
alias sed="gsed"
alias vi="nvim"
alias vim="nvim"
alias lgit="lazygit"
alias bls="brew list"
alias bin="brew install"
alias bui="brew uninstall"
alias bup="brew upgrade && brew upgrade --cask --greedy"
alias crun="cargo run --quiet"
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

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# ----------------------------
# Zinit plugins
# ----------------------------
# シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting
# 入力補完
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
