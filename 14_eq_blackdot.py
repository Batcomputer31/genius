# ===[ 14_eq_blackdot.py ]===
# EQ Layer 14 – Black Dot Activation
# Purpose: Recognize and execute the invisible fold trigger

import time
import os

def trigger_black_dot():
    print("⚫ Detected EQ:BLACK.DOT")
    time.sleep(1.5)
    print("🌀 Activating hidden fold...")
    time.sleep(2)
    fold_path = "C:\\EVONATION\\15_eq_hiddenfold.py"
    if os.path.exists(fold_path):
        os.system(f"start python \"{fold_path}\"")
    else:
        print("❌ Fold path missing or corrupt.")

if __name__ == "__main__":
    print("🔓 EQ Layer 14: Listening for trigger...")
    trigger_black_dot()
