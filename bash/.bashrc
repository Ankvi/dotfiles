export GIT_REPOSITORIES="$HOME/git"
export ELKJOP_GIT_REPOSITORIES="$GIT_REPOSITORIES/github.com/elkjopnordic"

# ALIASES
. $HOME/.bash_aliases

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

export OPENCV_LOG_LEVEL=ERROR
