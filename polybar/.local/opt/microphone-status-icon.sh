#!/usr/bin/env bash

MUTED=$(pactl get-source-mute @DEFAULT_SOURCE@)

if [[ $MUTED == "Mute: yes" ]]; then
    echo ""
else
    echo ""
fi
