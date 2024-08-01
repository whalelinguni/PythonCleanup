# Python Cleanup Script

![Python Cleanup](https://github.com/whalelinguni/PythonCleanup/blob/main/Untitled.png)

This PowerShell script is designed to clean up any remaining traces of Python installations on a Windows system. It also offers the option to download and run Geek Uninstaller to ensure a thorough cleanup.

## Features

- Detects if the script is running with administrative privileges and prompts for elevation if necessary.
- Downloads and extracts Geek Uninstaller for thorough application removal.
- Identifies and removes common Python installation directories.
- Cleans up Python-related environment variables.
- Provides a verbose output of all actions taken during the cleanup process.
- Offers an option to reboot the system after the cleanup is complete.

## Usage

1. **Clone the repository:**

   ```sh
   git clone https://github.com/yourusername/python-cleanup-script.git
   cd python-cleanup-script

2. **Run the PowerShell script:**

Open PowerShell as an Administrator and execute the script:
```
.\cleanup-python.ps1
```

3. **Follow the prompts:**

The script will guide you through the process, including downloading Geek Uninstaller, detecting Python installations, and performing the cleanup.
