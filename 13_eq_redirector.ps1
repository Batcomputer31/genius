# ===[ 13_eq_redirector.py ]===
# EQ Layer 13 – Redirector Protocol
# Purpose: Route flow to defined EQ layer or path based on dot signal

import json
import os

redirect_config = "C:\\EVONATION\\.eq\\redirector.json"

def load_redirect():
    if os.path.exists(redirect_config):
        with open(redirect_config, "r") as file:
            data = json.load(file)
            return data.get("target", None)
    return None

def launch_target(target):
    if target and os.path.exists(target):
        print(f"🔀 Redirecting to: {target}")
        os.system(f"start python \"{target}\"")
    else:
        print("⚠️ Target not found or not set.")

if __name__ == "__main__":
    print("🧭 EQ Redirector Initiated")
    target_path = load_redirect()
    launch_target(target_path)
