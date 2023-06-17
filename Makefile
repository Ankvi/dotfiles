stow:
	stow -t $(HOME) -v */

stow/work:
	stow -t $(HOME) -v alacritty bash nuget spotifyd startup webcam yarn

stow/adopt:
	stow -t $(HOME) -v --adopt */

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