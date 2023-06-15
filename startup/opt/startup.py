from datetime import datetime
import subprocess
import os.path
import shutil

# Get timestamp
timestamp = datetime.now()
SATURDAY = 5

# Define programs
TEAMS_APPIMAGE = "/opt/appimages/teams-for-linux.AppImage"
SLACK = shutil.which("slack")
ONEPASSWORD = shutil.which("1password")

if ONEPASSWORD is not None:
    subprocess.Popen([ONEPASSWORD])

# If it's not the weekend, open work related programs
if timestamp.weekday() < SATURDAY and timestamp.hour < 17:
    if os.path.isfile(TEAMS_APPIMAGE):
        subprocess.Popen([TEAMS_APPIMAGE])
    if SLACK is not None:
        subprocess.Popen([SLACK])
