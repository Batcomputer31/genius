# ===============================================
# 🔀 EQ MASTER SWITCHBOARD
# ===============================================

import json
import os

# Load ShellMatrix
shellmatrix_path = os.path.expanduser("~/Documents/Evoq/08_eq_shellmatrix.json")
with open(shellmatrix_path, "r") as f:
    matrix = json.load(f)

# Trigger controller
def route_signal(trigger_name):
    if trigger_name in matrix["trigger_lane"]:
        print(f"⚡ Signal: [{trigger_name}] → Trigger Lane → Executing {matrix['trigger_lane'][trigger_name]}")
        return matrix["trigger_lane"][trigger_name]

    elif trigger_name in matrix["identity_lane"]:
        print(f"🧬 Signal: [{trigger_name}] → Identity Lane → Loading {matrix['identity_lane'][trigger_name]}")
        return matrix["identity_lane"][trigger_name]

    elif trigger_name in matrix["locker_lane"]:
        print(f"🔐 Signal: [{trigger_name}] → Locker Lane → Deploying {matrix['locker_lane'][trigger_name]}")
        return matrix["locker_lane"][trigger_name]

    elif trigger_name in matrix["map_lane"]:
        print(f"🛰️ Signal: [{trigger_name}] → Map Lane → Accessing {matrix['map_lane'][trigger_name]}")
        return matrix["map_lane"][trigger_name]

    elif trigger_name in matrix["system_lane"]:
        print(f"🖥️ Signal: [{trigger_name}] → System Lane → Booting {matrix['system_lane'][trigger_name]}")
        return matrix["system_lane"][trigger_name]

    elif trigger_name in matrix["log_lane"]:
        print(f"🗂️ Signal: [{trigger_name}] → Log Lane → Logging {matrix['log_lane'][trigger_name]}")
        return matrix["log_lane"][trigger_name]

    else:
        print(f"❌ Unknown trigger signal: {trigger_name}")
        return None

# Example test route
if __name__ == "__main__":
    test_triggers = ["dot_trigger", "sigil", "engine", "structure", "init_script", "artifact_log"]
    for trig in test_triggers:
        route_signal(trig)
