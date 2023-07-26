import i3ipc
from subprocess import Popen
import os.path

wallpapersPath = "$HOME/Pictures/wallpapers/"
portraitPath = os.path.expandvars(wallpapersPath + "background-portrait.jpg")
landscapePath = os.path.expandvars(wallpapersPath + "background.png")


def is_landscape(rect: i3ipc.Rect) -> bool:
    result = rect.width > rect.height
    print(result)
    return result


connection = i3ipc.Connection()

outputs = connection.get_outputs()

command = ["feh", "--no-fehbg"]

for output in filter(lambda o: o.active, outputs):
    command.append("--bg-fill")
    command.append(landscapePath if is_landscape(output.rect) else portraitPath)

Popen(command)
