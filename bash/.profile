STARTUP_SCRIPT="$HOME/opt/startup.py"

. "$HOME/.kvist.profile"

if test -f $STARTUP_SCRIPT; then
    python $STARTUP_SCRIPT
fi