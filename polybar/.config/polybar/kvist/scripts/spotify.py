#!/usr/bin/env python

import dbus
from sys import argv

class SpotifyNotRunningError(Exception):
    pass

class CouldNotConnectToSpotifyError(Exception):
    pass

class InvalidCommandError(Exception):
    pass

DBUS_OBJECT_PATH = '/org/mpris/MediaPlayer2'
DBUS_PROPERTIES_INTERFACE = 'org.freedesktop.DBus.Properties'
DBUS_PLAYER_INTERFACE = 'org.mpris.MediaPlayer2.Player'

class SpotifyModule:
    def __init__(self):
        self.bus = dbus.SessionBus()

        for service in self.bus.list_names():
            if "spotify" in service:
                self.spotifyd_mpris_instance = service

        if self.spotifyd_mpris_instance is None:
            raise SpotifyNotRunningError

        self.spotifyd = self.bus.get_object(self.spotifyd_mpris_instance, DBUS_OBJECT_PATH, False)
        if self.spotifyd is None:
            raise CouldNotConnectToSpotifyError

        self.properties = dbus.Interface(self.spotifyd, DBUS_PROPERTIES_INTERFACE)
        self.player = dbus.Interface(self.spotifyd, DBUS_PLAYER_INTERFACE)

    def get_song_info(self):
        metadata = self.properties.Get(DBUS_PLAYER_INTERFACE, 'Metadata')
        title = metadata.get('xesam:title', 'Unknown title')
        artists = metadata.get('xesam:artist', ['Unknown artists'])
        artist = ", ".join(artists)
        return f'{artist} - {title}'

    def get_status(self):
        return self.properties.Get(DBUS_PLAYER_INTERFACE, 'PlaybackStatus')

    def play_pause(self):
        self.player.PlayPause()

    def print_song_info(self):
        status = self.get_status()
        match status:
            case 'Playing':
                song_info = self.get_song_info()
                print(song_info)
            case 'Paused':
                song_info = self.get_song_info()
                print(f'{song_info} (Paused)')
            case _:
                print('Stopped')

    def run_command(self, command):
        match command:
            case 'play_pause':
                self.play_pause()
            case 'print_song_info':
                self.print_song_info()
            case _:
                raise InvalidCommandError

if __name__ == '__main__':
    try:
        spotify_module = SpotifyModule()

        if len(argv) < 2:
            spotify_module.print_song_info()
            exit()

        spotify_module.run_command(argv[1])
    except SpotifyNotRunningError:
        print('Spotify is not running')
    except CouldNotConnectToSpotifyError:
        print('Could not connect to Spotify')
    except InvalidCommandError:
        print('Invalid command')
    except:
        print('Unknown error')
