import i3ipc
from subprocess import Popen
import os
import random

wallpapersPath = "$HOME/Pictures/wallpapers/"
portraitPath = os.path.expandvars(wallpapersPath + "background-portrait.jpg")
landscapePath = os.path.expandvars(wallpapersPath + "background.png")


def is_landscape(rect: i3ipc.Rect) -> bool:
    result = rect.width > rect.height
    print(result)
    return result


def get_random_wallpaper(rect: i3ipc.Rect) -> str:
    folderName = os.path.expandvars(
        f'{wallpapersPath}{rect.width}x{rect.height}')
    isFolder = os.path.isdir(folderName)
    if isFolder is None:
        return None
    wallpapers = os.listdir(folderName)

    if len(wallpapers) == 0:
        return None

    selected = random.randrange(len(wallpapers))
    return f'{folderName}/{wallpapers[selected]}'


connection = i3ipc.Connection()

outputs = connection.get_outputs()

command = ["feh", "--no-fehbg"]

for output in filter(lambda o: o.active, outputs):
    wallpaper = get_random_wallpaper(output.rect)
    if wallpaper is None:
        continue
    command.append("--bg-fill")
    command.append(wallpaper)

Popen(command)
