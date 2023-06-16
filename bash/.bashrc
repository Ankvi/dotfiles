# ALIASES
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -a'
alias gitpfwl='git push --force-with-lease'
alias start-redis='sudo service redis-server start'
alias stop-redis='sudo service redis-server stop'
alias list-used-ports='sudo lsof -i -P -n | grep LISTEN'
alias cdfincalc='cd ~/git/github.com/elkjopnordic/FINS/FinanceCalculator'
alias cdflash='cd ~/git/github.com/elkjopnordic/flash'
alias webcam='qv4l2'

export GIT_REPOSITORIES="$HOME/git"

export PROFILE_PATH="$HOME/.profile"

export LOCAL_FOLDER="$HOME/.local"
export BIN_FOLDER="$LOCAL_FOLDER/bin"
export OPT_FOLDER="$LOCAL_FOLDER/opt"

# PULUMI
export PULUMI_PATH=$HOME/.pulumi
export PATH=$PATH:$PULUMI_PATH/bin

# DOTNET
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# SNAP
export PATH=$PATH:/snap/bin

# GENERAL
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$BIN_FOLDER

# RUST
export PATH=$PATH:$HOME/.cargo/bin

export GITHUB_USERNAME=Ankvi
export NODE_OPTIONS="--max-old-space-size=8192"

if test -f /usr/share/bash-completion/bash_completion; then
    . /usr/share/bash-completion/bash_completion
fi