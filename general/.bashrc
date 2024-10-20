#!/usr/bin/env bash

export GIT_REPOSITORIES="$HOME/git"
export GIT_EDITOR='nvim'
export EDITOR='nvim'
export OPENER='rifle'
export ELKJOP_GIT_REPOSITORIES="$GIT_REPOSITORIES/github.com/elkjopnordic"

# Man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# ALIASES
. "$HOME"/.bash_aliases

export PROFILE_PATH="$HOME/.profile"

export LOCAL_FOLDER="$HOME/.local"
export BIN_FOLDER="$LOCAL_FOLDER/bin"
export OPT_FOLDER="$LOCAL_FOLDER/opt"

# PULUMI
export PULUMI_PATH=$HOME/.pulumi
export PATH=$PATH:$PULUMI_PATH/bin

# SNAP
export PATH=$PATH:/snap/bin

# DOTNET
export DOTNET_ROOT=/usr/share/dotnet/
export PATH="$PATH:$HOME/.dotnet/tools"

# GENERAL
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$BIN_FOLDER

export TERM=screen-256color

# RUST
export PATH=$PATH:$HOME/.cargo/bin

export GITHUB_USERNAME=Ankvi
export NODE_OPTIONS="--max-old-space-size=8192"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# NVM
# if test -f /usr/share/nvm/init-nvm.sh; then
#     . /usr/share/nvm/init-nvm.sh
# fi

if test -f "$HOME/.cargo/env"; then
    . "$HOME/.cargo/env"
fi

# if test -f /usr/share/bash-completion/bash_completion; then
#     . /usr/share/bash-completion/bash_completion
# fi

if test -f "$LOCAL_FOLDER/share/window-manager-config.sh"; then
    . "$LOCAL_FOLDER/share/window-manager-config.sh"
fi

export OPENCV_LOG_LEVEL=ERROR

export GTK_THEME='catppuccin-mocha-lavender-standard+default:dark'

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Enable the subsequent settings only in interactive sessions
# case $- in
# *i*) ;;
# *) return ;;
# esac

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(fzf --bash)"

_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

eval "$(starship init bash)"
