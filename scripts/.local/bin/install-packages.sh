#!/usr/bin/env bash

install_base_packages() {
    sudo pacman -S base-devel networkmanager networkmanager-dmenu neofetch vi vim neovim \
        man-db man-pages texinfo git stow spotifyd piper discord noto-fonts-emoji \
        ttf-jetbrains-mono-nerd dkms linux-headers flameshot thunderbird wmctrl \
        pcmanfm-gtk3 ripgrep lazygit bashtop numlockx dunst
}

install_python_packages() {
    sudo pacman -S python-dotenv python-dbus python-os python-requests \
        python-i3ipc python-psutil
}

install_nvidia_driver_packages_proprietary() {
    sudo pacman -S nvidia nvidia-utils
}

install_nvidia_driver_packages_open_source() {
    sudo pacman -S xf86-video-nouveau mesa
}

install_intel_driver_packages() {
    sudo pacman -S mesa
}

install_x11_packages() {
    sudo pacman -S xinit xrandr arandr autorandr
}

install_i3_packages() {
    install_x11_packages

    sudo pacman -S xorg-server i3-wm i3lock xss-lock alacritty breeze-gtk \
        feh xorg-xinput xorg-xinit picom xclip
}

install_sway_packages() {
    sudo pacman -S sway swaylock swayidle wl-clipboard xorg-xwayland grim
}

install_development_packages() {
    sudo pacman -S nodejs npm aspnet-runtime aspnet-runtime-6.0 dotnet-sdk dotnet-sdk-6.0 \
        kubectl k9s docker docker-compose docker-buildx
}

install_aur_packages() {
    yay x11-emoji-picker-git snapd teams-for-linux-appimage google-chrome microsoft-edge-stable-bin spotify-tui \
        visual-studio-code-bin 1password cura-bin azure-cli nordvpn-bin
}

install_arduino() {
    curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=$BIN_FOLDER sh
}

install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_yay() {
    pacman -S --needed git base-devel
    mkdir -p ~/git/aur
    cd ~/git/aur || echo "Could not create AUR folder. Exiting" && exit
    git clone https://aur.archlinux.org/yay.git
    cd yay || echo "Could not enter yay folder. Exiting" && exit
    makepkg -si
}

install_desktop_packages() {
    install_base_packages
    install_development_packages
    install_yay
    install_nvidia_driver_packages_proprietary
    install_i3_packages
    install_aur_packages
}

install_laptop_packages() {
    install_base_packages
    install_development_packages
    install_intel_driver_packages
    install_yay
    install_sway_packages
}

subcommand=$1

install_${subcommand}

if [ $? = 127 ]; then
    echo "Command not recognized"
    exit
fi
