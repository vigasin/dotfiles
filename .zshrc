# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose aws zsh-autosuggestions zsh-syntax-highlighting pyenv)

source $ZSH/oh-my-zsh.sh

unalias gam

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='nvim'

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

bindkey \^U backward-kill-line

#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git 
#zstyle ':vcs_info:(git*):*' use-simple true
#precmd() { vcs_info }

#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs virtualenv docker_machine)

export GOPATH=$HOME/workspace/go
export PATH=$HOME/bin:$GOPATH/bin:$PATH

export AWS_REGION=us-east-1
export AWS_PAGER=""

export CAMDIGGER_CONF_DIR=$HOME/workspace/camdigger/etc/dev
export ANALYTICS_CONF_DIR=$HOME/workspace/analytics/etc/dev

export ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault_pass.txt
export LEDGER_FILE=$HOME/Library/CloudStorage/GoogleDrive-ivigasin@gmail.com/My\ Drive/AppData/finances.ledger

export PGHOST=localhost
export PGUSER=postgres
export PGPORT=5432

alias so='source env/bin/activate'
alias e='emacsclient -t'
alias dsh='docker-machine ssh'

alias lbe='ledger bal -X $ ^Envelopes'
alias lbd='ledger bal -X $ ^Debts'
alias lba='ledger bal -X $ ^Assets ^Liabilities'

#virtualenvwrapper_lazy="$(which virtualenvwrapper_lazy.sh 2> /dev/null)"
#if [ -f "$virtualenvwrapper_lazy" ]; then
#  source "$virtualenvwrapper_lazy"
#  workon default
#fi

# eval "$(rbenv init -)"
unsetopt share_history
export PATH="/usr/local/opt/gpg-agent/bin:$PATH"
export PATH=$PATH:$HOME/sdk/flutter/bin

# export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# [[ "$HOST" =~ "bmac*" ]] && dm vigub

# The next line updates PATH for the Google Cloud SDK.
# if [ -f "$HOME/sdk/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/sdk/google-cloud-sdk/path.zsh.inc"; fi

function gam() { "$HOME/bin/gam/gam" "$@" ; }
[ -f ~/.secrets.sh ] && source ~/.secrets.sh
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

if [ -d "$HOME/ivigasin@gmail.com - Google Drive/My Drive/Scripts" ]; then
  PATH=$PATH:"$HOME/ivigasin@gmail.com - Google Drive/My Drive/Scripts"
fi

if [ -d "$HOME/.cargo/bin" ]; then
  PATH=$PATH:$HOME/.cargo/bin
fi


which gh >& /dev/null && eval "$(gh copilot alias -- zsh)"

# ---- FZF -----

if [ -d "$HOME/.fzf/bin" ]; then
  PATH=$PATH:$HOME/.fzf/bin
fi

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh | sd 'builtin cd --' 'cd')"


# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --exclude .terragrunt-cache"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude .terragrunt-cache"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.fzf-git/fzf-git.sh

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
#export FZF_DEFAULT_OPTS="--color=bg+:${bg_highlight},gutter:-1"

# ----- Bat (better cat) -----

export BAT_THEME="tokyonight_night"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# ---- Eza (better ls) -----

alias ls="eza --color=always --git"

# thefuck alias
#eval $(thefuck --alias)
eval $(thefuck --alias blya)

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"
alias vi=nvim

alias incrc='cat run_config.yaml | yq ".module_versions.app |= (split(\".\") | .[2] = ((.[2] | tonumber) + 1 | tostring) | join(\".\"))" | yq -y > tmp.yaml; mv tmp.yaml run_config.yaml; cat run_config.yaml'

[ -f ~/.cargo/env ] && source $HOME/.cargo/env

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
