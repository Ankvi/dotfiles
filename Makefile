stow:
	stow -t $(HOME) -v */

unstow:
	stow -t $(HOME) -v --delete */