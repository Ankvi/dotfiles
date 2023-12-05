########################################
# Define the list of directories to
# install
########################################
COMMON=bash nuget spotifyd startup webcam yarn wallpapers vim alacritty dunst neovim git lazygit scripts gtk
WORK=$(COMMON) sway
DESKTOP=$(COMMON) arduino cura i3


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
# Ignoring changes to certain files that
# will contain secrets.
# Do this before stowing files
########################################

untrack-files-with-secrets:
	git update-index --assume-unchanged nuget/.nuget/NuGet/NuGet.Config
	git update-index --assume-unchanged yarn/.yarnrc.yml
	git update-index --assume-unchanged spotifyd/.config/spotifyd/spotifyd.conf

track-files-with-secrets:
	git update-index --no-assume-unchanged nuget/.nuget/NuGet/NuGet.Config
	git update-index --no-assume-unchanged yarn/.yarnrc.yml
	git update-index --no-assume-unchanged spotifyd/.config/spotifyd/spotifyd.conf

########################################
# (Re)activate polybar
########################################

polybar/start:
	./polybar/.polybar/launch.sh

