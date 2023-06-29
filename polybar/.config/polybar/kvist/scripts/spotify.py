#!/usr/bin/env python

import dbus
import os

class SpotifyModule:
    def __init__(self):
        self.bus = dbus.SessionBus()
        self.spotifyd = self.bus.get_object('com.spotifyd.Bus', '/com/spotifyd/Controller')
        self.spotifyd_interface = dbus.Interface(self.spotifyd, 'org.freedesktop.DBus.Properties')

    def get_song_info(self):
        metadata = self.spotifyd_interface.Get('org.freedesktop.DBus.Properties', 'Metadata')
        title = metadata['mpris:trackid'].split(':')[2]
        artist = metadata['xesam:artist'][0]
        return f'{artist} - {title}'

    def is_playing(self):
        status = self.spotifyd_interface.Get('org.freedesktop.DBus.Properties', 'PlaybackStatus')
        return status == 'Playing'

    def display_module(self):
        if self.is_playing():
            song_info = self.get_song_info()
            print(f' {song_info}')  # Modify the icon and format as per your preference
        else:
            print('')  # Empty output when Spotify is not playing

if __name__ == '__main__':
    spotify_module = SpotifyModule()
    spotify_module.display_module()
