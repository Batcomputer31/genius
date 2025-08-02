# ===[ 11_eq_pathtrace.py ]===
# EQ PathTrace – Layer 11
# Purpose: Trace EQ system paths and verify link states

import os
from datetime import datetime

# EQ Layer 11 Path Registry
eq_paths = {
    "eq_launcher": "C:\\EVONATION\\launch.bat",
    "eq_shell": "C:\\EVONATION\\dread.ps1",
    "eq_dot": "C:\\EVONATION\\.hidden\\trigger.dot",
    "eq_config": "C:\\EVONATION\\config\\eqcfg.json",
    "eq_log": "C:\\EVONATION\\logs\\eq_live.log"
}

def eq_path_trace():
    print("🔁 EQ PATH TRACE [Layer 11]")
    for label, path in eq_paths.items():
        result = "🟢 FOUND" if os.path.exists(path) else "🔴 MISSING"
        print(f"{label} → {path} = {result}")

def eq_log_trace():
    with open(eq_paths["eq_log"], "a") as log:
        time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log.write(f"[{time}] EQ Layer 11 trace complete\n")

if __name__ == "__main__":
    eq_path_trace()
    eq_log_trace()
    print("✅ EQ Layer 11 complete.")
