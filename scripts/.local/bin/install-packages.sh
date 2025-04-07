#!/usr/bin/env bash

install_base() {
  echo "Installing base packages"
  sudo pacman -S --needed base-devel networkmanager vi vim \
    man-db man-pages texinfo git stow piper discord noto-fonts-emoji gtk4 \
    ttf-jetbrains-mono-nerd tmux yazi spotify-launcher gtk3 gtk2 \
    pcmanfm-gtk3 ripgrep lazygit bashtop dunst alacritty polkit xdg-desktop-portal \
    xdg-desktop-portal-gtk pipewire-pulse pamixer pavucontrol grub efibootmgr \
    bluez bluez-utils firefox calc gnome-themes-extra acpid fuse2 fuse3 fd \
    gvfs usbutils fzf bat lsof starship jq udisks2 bash-completion
}

install_intel_cpu() {
  echo "Installing Intel CPU packages"
  sudo pacman -S --needed intel-ucode
}

install_keyring() {
  echo "Installing keyring packages"
  sudo pacman -S --needed gnome-keyring seahorse
}

install_python() {
  echo "Installing python packages"
  sudo pacman -S --needed python-dotenv python-dbus python-os python-requests \
    python-i3ipc python-psutil
}

install_nvidia_driver_proprietary() {
  echo "Installing proprietary Nvidia packages"

  sudo pacman -S --needed dkms linux-headers nvidia-dkms nvidia-utils lib32-nvidia-utils \
    libva-nvidia-driver
}

install_nvidia_driver_open_source() {
  echo "Installing open sourced Nvidia packages"
  sudo pacman -S --needed xf86-video-nouveau mesa
}

install_intel_driver() {
  echo "Installing Intel GPU packages"
  sudo pacman -S --needed mesa
}

install_wayland() {
  echo "Installing wayland packages"
  sudo pacman -S --needed xorg-xwayland wl-clipboard grim slurp waybar rofi-wayland swappy rofi-emoji

  install_wayland_aur_packages
}

install_sway() {
  echo "Installing sway wm packages"
  install_wayland

  sudo pacman -S --needed sway swaylock swayidle swaybg \
    xdg-desktop-portal-wlr
}

install_hyprland() {
  echo "Installing hyprland packages"

  install_wayland
  sudo pacman -S --needed \
    hyprland libva qt6-wayland qt6ct \
    hypridle
}

install_development_tools() {
  echo "Installing software development packages"
  echo "Techs: .NET, Node.JS, Docker, Kubernetes, Java"
  sudo pacman -S --needed \
    kubectl k9s docker docker-compose docker-buildx \
    aspnet-runtime aspnet-runtime-6.0 aspnet-runtime-7.0 \
    dotnet-sdk dotnet-sdk-6.0 dotnet-sdk-7.0 \
    dotnet-sdk-8.0 aspnet-runtime-8.0 \
    jre-openjdk azure-cli \
    rust-analyzer \
    lua lua51 luarocks

  echo "Installing tauri app related packages"
  sudo pacman -S --needed \
    webkit2gtk

  yay -S nvm powershell-bin
}

install_wifi_card_drivers() {
  yay -S rtw88-dkms-git
}

install_aur_packages() {
  echo "Installing AUR packages"
  yay -S microsoft-edge-stable-bin \
    visual-studio-code-bin 1password catppuccin-gtk-theme-mocha \
    lazydocker docker-credential-pass
}

install_wayland_aur_packages() {
  echo "Installing wayland AUR packages"
  install_aur_packages
  yay -S wdisplays wlogout
}

install_gaming_packages() {
  yay -S wowup-cf-bin
}

install_cura() {
  echo "Installing Cura"
  yay -S cura-bin
}

install_arduino() {
  echo "Installing the Arduino CLI"
  curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=$BIN_FOLDER sh
}

install_rust() {
  echo "Installing Rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_bun() {
  echo "Installing bun.js"
  curl -fsSL https://bun.sh/install | bash
}

install_pulumi() {
  echo "Installing Pulumi"
  curl -fsSL https://get.pulumi.com | sh
}

install_deno() {
  echo "Installing deno"
  curl -fsSL https://deno.land/install.sh | sh
}

install_nvm() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
}

install_extras() {
  install_arduino
  install_rust
  install_bun
  install_pulumi
  install_deno
}

install_yay() {
  if command -v yay &>/dev/null; then
    echo "yay is already installed. skipping"
    return
  fi

  echo "Installing yay"
  sudo pacman -S --needed git base-devel
  mkdir -p ~/git/aur
  cd ~/git/aur || echo "Could not create AUR folder. Exiting" && exit
  git clone https://aur.archlinux.org/yay.git
  cd yay || echo "Could not enter yay folder. Exiting" && exit
  makepkg -si
}

install_desktop() {
  echo "Installing desktop packages"
  install_base
  install_intel_cpu
  install_development_tools
  install_yay

  install_nvidia_driver_proprietary
  install_hyprland

  install_gaming_packages
  install_extras
}

install_laptop() {
  echo "Installing laptop packages"
  install_base
  install_intel_cpu
  install_development_tools
  install_yay

  install_intel_driver

  install_sway
  install_extras
}

subcommand=$1

if [ "$subcommand" = "" ]; then
  echo "Please provide a sub command"
  exit
fi

install_"${subcommand}"

if [ $? = 127 ]; then
  echo "Command not recognized"
  exit
fi
