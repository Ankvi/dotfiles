from datetime import datetime
import subprocess
import os.path
import shutil
import psutil

# Get timestamp
timestamp = datetime.now()
SATURDAY = 5

# Define programs
TEAMS_APPIMAGE = "/opt/appimages/teams-for-linux.AppImage"
SLACK = "slack"
ONEPASSWORD = "1password"
YAKUAKE = "yakuake"
POLYBAR = "polybar"

def is_process_running(name):
    for proc in psutil.process_iter(attrs=['pid', 'name']):
        if proc.name() == name:
            print(f"Process {name} is running")
            return True

    return False

def start_appimage_if_not_running(appimage):
    if not os.path.isfile(appimage):
        return

    basename = os.path.basename(appimage)
    if not is_process_running(basename):
        subprocess.Popen([appimage])

def start_if_not_running(name, command = None):
    program = shutil.which(name)
    if program is None:
        return

    if not is_process_running(name):
        subprocess.Popen([command if command is not None else program])

start_if_not_running(ONEPASSWORD)
start_if_not_running(YAKUAKE)
start_if_not_running(POLYBAR, "~/.config/polybar/kvist/launch.sh")

# If it's not the weekend, open work related programs
if timestamp.weekday() < SATURDAY and timestamp.hour < 17:
    print("It's a work day, opening work programs")

    start_appimage_if_not_running(TEAMS_APPIMAGE)
    start_if_not_running(SLACK)
