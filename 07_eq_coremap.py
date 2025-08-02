# ========================================
# 🧠 EQ SYSTEM COREMAP FILE
# ========================================

import os
import json

EQ_CORE_PATH = os.path.expanduser("~/Documents/Evoq")  # Adjust if needed

core_files = [
    "CEVONATION.ps1",
    "eq_identity_lock",
    "locked_identity.json",
    "eq_dot_trigger",
    "locker_engine",
    "orbit_map",
    "hidden.trigger",
    "BLACKBOARDBOOK",
    "EQ_SIGIL_001_DIGIHASH",
    "EQ_ARTIFACT_LOG_001",
    "04_eq_identity_bridge",
    "05_eq_struct.json",
    "06_hidden_injector"
]

coremap = {
    "system_root": EQ_CORE_PATH,
    "identity": "RA:CREATOR",
    "frequency": "77777-Hz",
    "files": core_files
}

# Save to static JSON file
with open(os.path.join(EQ_CORE_PATH, "07_eq_coremap.json"), "w") as f:
    json.dump(coremap, f, indent=4)

print("✅ EQ Coremap Generated @", os.path.join(EQ_CORE_PATH, "07_eq_coremap.json"))
