from datetime import datetime
import subprocess

# Get timestamp
timestamp = datetime.now()

SATURDAY = 5

# If it's not the weekend, open work related programs
if timestamp.weekday() < SATURDAY and timestamp.hour < 17:
    subprocess.Popen(["teams-for-linux"])
    subprocess.Popen(["slack"])
