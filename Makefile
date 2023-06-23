COMMON=bash nuget spotifyd startup webcam yarn rofi kde
WORK=$(COMMON)
DESKTOP=$(COMMON) arduino cura kde-desktop

stow/base:
	stow -t $(HOME) -v stow-config

stow: stow/base
	stow -t $(HOME) -v $(DESKTOP)

stow/work: stow/base
	stow -t $(HOME) -v $(WORK)

stow/adopt:
	stow -t $(HOME) -v --adopt $(DESKTOP)

stow/work/adopt:
	stow -t $(HOME) -v --adopt $(WORK)

unstow:
	stow -t $(HOME) -v --delete */

untrack-files-with-secrets:
	git update-index --assume-unchanged nuget/.nuget/NuGet/NuGet.Config
	git update-index --assume-unchanged yarn/.yarnrc.yml
	git update-index --assume-unchanged spotifyd/.config/spotifyd/spotifyd.conf

track-files-with-secrets:
	git update-index --no-assume-unchanged nuget/.nuget/NuGet/NuGet.Config
	git update-index --no-assume-unchanged yarn/.yarnrc.yml
	git update-index --no-assume-unchanged spotifyd/.config/spotifyd/spotifyd.conf