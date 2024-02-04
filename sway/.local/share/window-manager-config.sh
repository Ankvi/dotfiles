export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export QT_QPA_PLATFORM=wayland
export SWAY_CONFIG_FOLDER="$HOME/.config/sway"


if command -v nvidia-smi &> /dev/null; then
    export WLR_RENDERER=vulkan
    export WLR_NO_HARDWARE_CURSORS=1
    export XWAYLAND_NO_GLAMOR=1
fi
