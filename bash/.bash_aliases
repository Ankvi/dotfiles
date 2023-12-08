#!/usr/bin/env bash

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -a'

# GIT
alias gitpfwl='git push --force-with-lease'
alias lgit='lazygit'

# REDIS
alias start-redis='sudo service redis-server start'
alias stop-redis='sudo service redis-server stop'

# Mounting USB storage devices
alias mount-3d-sd-card='sudo mount -o gid=andreas,fmask=113,dmask=002 UUID="18F3-DE3E" /media/usb-drive/'
alias unmount-3d-sd-card='sudo umount UUID="18F3-DE3E"'

# Mounting Raspberry PI Pico
alias mount-rpi='sudo mount -o gid=andreas,fmask=113,dmask=002 LABEL="CIRCUITPY" /media/pico/'
alias unmount-rpi='sudo umount LABEL="CIRCUITPY"'

# OTHER SHIT
alias list-used-ports='sudo lsof -i -P -n | grep LISTEN'
alias cdfincalc='cd $ELKJOP_GIT_REPOSITORIES/FINS/FinanceCalculator'
alias cdflash='cd $ELKJOP_GIT_REPOSITORIES/flash'
alias elkjop='cd $ELKJOP_GIT_REPOSITORIES'
alias webcam='qv4l2'
alias vim='nvim'
alias dotfiles='cd ~/git/github.com/Ankvi/dotfiles'

alias warcraft='cd /home/andreas/Games/battlenet/drive_c/Program\ Files\ \(x86\)/World\ of\ Warcraft'

