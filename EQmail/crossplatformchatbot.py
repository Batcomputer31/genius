import subprocess
import platform

def run_command(cmd, shell=False):
    result = subprocess.run(cmd, shell=shell, capture_output=True, text=True)
    print(result.stdout)
    if result.returncode != 0:
        print("Error:", result.stderr)

if platform.system() == "Windows":
    # Run a PowerShell command
    run_command(["powershell", "-Command", "Write-Host 'Hello from PowerShell!'"])
else:
    # Run a Bash command
    run_command(["bash", "-c", "echo 'Hello from Bash!'"])
