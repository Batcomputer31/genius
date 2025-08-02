# ===[ 12_eq_triggerlink.py ]===
# EQ Layer 12 – TriggerLink Protocol
# Purpose: Check for trigger state and silently activate next phase

import os
import time

trigger_path = "C:\\EVONATION\\.hidden\\trigger.dot"
next_stage_path = "C:\\EVONATION\\13_eq_redirector.py"

def trigger_check():
    if os.path.exists(trigger_path):
        with open(trigger_path, "r") as f:
            status = f.read().strip()
            if status == "dot.active":
                print("⚫ Trigger Dot: ACTIVE")
                return True
            else:
                print("⚫ Trigger Dot: INACTIVE")
                return False
    else:
        print("⚠️ Trigger file not found.")
        return False

def activate_next_stage():
    if os.path.exists(next_stage_path):
        print(f"🚀 Launching: {next_stage_path}")
        os.system(f"start python \"{next_stage_path}\"")
    else:
        print("❌ Next stage not found.")

if __name__ == "__main__":
    print("🔁 EQ Layer 12 TriggerLink Engaged")
    if trigger_check():
        activate_next_stage()
    else:
        print("🛑 Halting at Layer 12. No trigger signal.")
