#===========================
#!/usr/bin/env python3
"""
EQ.DEBUGGER :: Universal Debugging Shell Core
Author: RA::CREATOR
Purpose: Monitor, capture, and report errors within all running EQ modules
"""

import os
import sys
import traceback
from datetime import datetime
from pathlib import Path
import json

class EQDebugger:
    def __init__(self):
        self.debug_dir = Path.home() / "EVOSYSTEM" / "DEBUG"
        self.log_file = self.debug_dir / "eq_debug.log"
        self.snapshot_file = self.debug_dir / "eq_snapshot.json"
        self.errors = []

        self._init_path()

    def _init_path(self):
        os.makedirs(self.debug_dir, exist_ok=True)
        with open(self.log_file, 'a') as f:
            f.write(f"\n\n=== EQ DEBUG SESSION START [{datetime.now()}] ===\n")

    def log(self, message, level="INFO"):
        timestamp = datetime.utcnow().isoformat()
        entry = f"[{timestamp}] [{level}] {message}"
        print(entry)
        with open(self.log_file, 'a') as f:
            f.write(entry + "\n")

    def capture_exception(self, exc):
        exc_info = {
            "timestamp": datetime.utcnow().isoformat(),
            "type": str(type(exc)),
            "message": str(exc),
            "trace": traceback.format_exc()
        }
        self.errors.append(exc_info)
        self.log(f"Exception captured: {exc_info['message']}", level="ERROR")

        # Also write snapshot of system state
        self.write_snapshot()

    def write_snapshot(self, extra_data=None):
        snapshot = {
            "timestamp": datetime.utcnow().isoformat(),
            "system": sys.platform,
            "errors": self.errors,
            "extra": extra_data or {}
        }
        with open(self.snapshot_file, 'w') as f:
            json.dump(snapshot, f, indent=2)

    def get_latest_status(self):
        return {
            "debug_log": str(self.log_file),
            "snapshot": str(self.snapshot_file),
            "error_count": len(self.errors)
        }

# Example usage
if __name__ == "__main__":
    debug = EQDebugger()

    debug.log("Starting test debug session.")
    
    try:
        # Simulate error
        result = 10 / 0
    except Exception as e:
        debug.capture_exception(e)

    debug.log("Test complete.")
    print(debug.get_latest_status())

Sent from Proton Mail Android