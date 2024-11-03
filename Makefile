########################################
# Define the list of directories to
# install
########################################
COMMON=general gtk spotifyd startup webcam wallpapers alacritty dunst k9s lazygit scripts pipewire tmux wayland wezterm yazi
WORK=$(COMMON) sway
DESKTOP=$(COMMON) arduino cura hyprland


########################################
# Stow dotfiles
########################################

stow/base:
	stow -t $(HOME) -v stow-config

stow: stow/base
	stow -t $(HOME) -v $(DESKTOP)

stow/work: stow/base
	stow -t $(HOME) -v $(WORK)

restow:
	stow -R -t $(HOME) -v $(DESKTOP)

restow/work:
	stow -R -t $(HOME) -v $(WORK)


########################################
# Previewing GNU Stow symlinks
########################################

stow/preview:
	stow -t $(HOME) -v --simulate $(DESKTOP)

stow/work/preview:
	stow -t $(HOME) -v --simulate $(WORK)


########################################
# Copy files from system to dotfiles
########################################

stow/adopt:
	stow -t $(HOME) -v --adopt $(DESKTOP)

stow/work/adopt:
	stow -t $(HOME) -v --adopt $(WORK)


########################################
# Removing GNU Stow symlinks
########################################

unstow:
	stow -t $(HOME) -v --delete */

########################################
# (Re)activate polybar
########################################

polybar/start:
	./polybar/.polybar/launch.sh

