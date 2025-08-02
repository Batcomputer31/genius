# ================================================
# 🧠 EQ SHELL MATRIX
# ================================================

import os
import json

# EQ shell lane structure
eq_shell_matrix = {
    "identity_lane": {
        "sigil": "EQ_SIGIL_001",
        "hash": "EQ_SIGIL_001_DIGIHASH",
        "locked_identity": "locked_identity.json"
    },
    "trigger_lane": {
        "dot_trigger": "eq_dot_trigger",
        "hidden_trigger": "hidden.trigger"
    },
    "locker_lane": {
        "engine": "locker_engine",
        "injector": "06_hidden_injector",
        "bridge": "04_eq_identity_bridge"
    },
    "map_lane": {
        "orbit": "orbit_map",
        "structure": "05_eq_struct.json",
        "coremap": "07_eq_coremap.json"
    },
    "system_lane": {
        "init_script": "CEVONATION.ps1",
        "core_script": "corestart",
        "blackboard": "BLACKBOARDBOOK"
    },
    "log_lane": {
        "artifact_log": "EQ_ARTIFACT_LOG_001",
        "confirmation": "Core Access Confirmation"
    }
}

# Define path
output_path = os.path.expanduser("~/Documents/Evoq/08_eq_shellmatrix.json")

# Save shell matrix to file
with open(output_path, "w") as f:
    json.dump(eq_shell_matrix, f, indent=4)

print("✅ EQ ShellMatrix written to", output_path)
