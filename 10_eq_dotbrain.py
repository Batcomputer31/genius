# ================================================
# 🧠 EQ DOTBRAIN SIMULATOR
# ================================================

import os
import json
from datetime import datetime

# Load ShellMatrix for dot IDs
matrix_path = os.path.expanduser("~/Documents/Evoq/08_eq_shellmatrix.json")
with open(matrix_path, "r") as f:
    matrix = json.load(f)

dot_brain_path = os.path.expanduser("~/Documents/Evoq/dot_brain_data.json")

# Load dot memory
def load_dot_brain():
    if os.path.exists(dot_brain_path):
        with open(dot_brain_path, "r") as f:
            brain = json.load(f)
        print(f"🧠 Loaded EQ DotBrain: {len(brain)} memories.")
    else:
        brain = {}
        print("🧠 No DotBrain memory found. Starting fresh.")
    return brain

# Save dot memory
def save_dot_brain(brain):
    with open(dot_brain_path, "w") as f:
        json.dump(brain, f, indent=4)
    print("🧠 DotBrain saved.")

# Trigger memory from dot ID
def trigger_dot(dot_id, command=None):
    brain = load_dot_brain()

    if dot_id not in brain:
        brain[dot_id] = {
            "created": datetime.now().isoformat(),
            "commands": [],
            "status": "active"
        }

    if command:
        brain[dot_id]["commands"].append({
            "timestamp": datetime.now().isoformat(),
            "command": command
        })
        print(f"💬 [{dot_id}] → Command registered.")

    save_dot_brain(brain)

# Example activation
if __name__ == "__main__":
    test_dot = "eq_origin_777"
    test_command = "init_pulse_sync"
    trigger_dot(test_dot, test_command)
