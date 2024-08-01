clear-host
write-host ""
$face = @"
            ||||||||||||||
           =              \       ,
           =               |
          _=            ___/
         / _\           (o)\
        | | \            _  \
        | |/            (____)
         \__/          /   |
          /           /  ___)
         /    \       \    _) 
        \      \           /  
      \/ \      \_________/  
       \/ \      /            
        \/ \    /          
         \/ \  /     
"@

$snek = @"







                                                                                        ____
                                                                                       / . .\
                                                                                       \  ---<
                                                                                        \  /
                                                                              __________/ /
                                   ........       .....        ......      -=:___________/
"@

$facegn = @"
            ||||||||||||||
           =              \       ,
           =               |
          _=            ___/
         / _\           (o)\
        | | \            _  \
        | |/            (____)
         \__/          /   |
          /           /  ___)
         /    \       \    _)                       )
        \      \           /                       (
      \/ \      \_________/   |\_________________,_ )
       \/ \      /            |     ==== _______)__)
        \/ \    /           __/___  ====_/
         \/ \  /           (O____)\\_(_/
                          (O_ ____)
                           (O____)
"@

$death = @"
                              /`._      ,
                             /     \   / \
                             ) ,-==-> /\/ \
                              )__\\/ // \  |
                             /  /' \//   | |
                            /  (  /|/    | /
                           /     //|    /,'
                          // /  (( )    '
                         //     // \    |             ____
                        //     (#) |                 / x x\
                       /        )\/ \   '            \  ---.
                      /        /#/   )                \  /
                     /         \#\  /)      __________/ /
                     //   _____/#/_/'    -=:___________/
"@

function TypeWrite {
    param(
        [string]$text, 
        [int]$speed = 50
    )

    try {
        $Random = New-Object System.Random
        $text -split '' | ForEach-Object {
            Write-Host -NoNewline $_
            Start-Sleep -Milliseconds $(1 + $Random.Next($speed))
        }
        Write-Host ""
    } catch {
        Write-Host "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
    }
}

Write-Host $snek
Start-Sleep -Seconds 1
Clear-Host
Write-Host $face
Start-Sleep -Seconds 1
Clear-Host
Write-Host $snek
Start-Sleep -Seconds 1
Clear-Host
Write-Host $face
Start-Sleep -Seconds 1
Clear-Host
Write-Host $snek
Start-Sleep -Seconds 1
Clear-Host
Write-Host $facegn
Start-Sleep -Seconds 1
Clear-Host
Write-Host $death
TypeWrite "   		    		     fuck you snek."
Start-Sleep -Seconds 2

clear-host

# Define the script directory
$scriptDir = (Get-Location).Path
$geekUninstallerUrl = "https://geekuninstaller.com/geek.7z"
$geekUninstallerPath = Join-Path $scriptDir "GeekUninstaller.7z"  # Use .7z extension
$sevenZipPath = "C:\Program Files\7-Zip\7z.exe"  # Adjust if needed

# Self-elevate the script if required
cls
Write-Host "########-----     [ Detecting Elevation Status ]     -----########"
Write-Host "     User will be prompted by UAC if elevation is required."
Write-Host "#################################################################`n"
Start-Sleep -Seconds 3

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb RunAs -ArgumentList $CommandLine -WindowStyle Hidden
        Exit
    }
}

function Reboot-System {
    try {
        # Execute the reboot command
        shutdown /r /t 0
        Write-Host "Reboot initiated successfully."
    } catch {
        Write-Host "An error occurred while attempting to reboot: $_"
    }
}

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"
Clear-Host

$splash = @"
  _ \         |    |                          ___| |                                               
 |   | |   |  __|  __ \    _ \   __ \        |     |   _ \   _  |  __ \   |   |  __ \    _ \   __| 
 ___/  |   |  |    | | |  (   |  |   |       |     |   __/  (   |  |   |  |   |  |   |   __/  |    
_|    \__. | \__| _| |_| \___/  _|  _|      \____|_| \___| \__._| _|  _| \__._|  .__/  \___| _|    
      ____/                                                                     _|                 
---------------------------------------------------------------------------------------------------
                                                                               --Whale Linguini
"@

Write-Host ""
Write-Host $splash
Write-Host ""
Start-Sleep -Seconds 2
# Inform the user
Write-Host "----------------"
Write-Host "This script is intended to be run for more extra cleaning after Python(s) has been uninstalled."
Write-Host "Whales wisdom suggested to use Geek Uninstaller to initiate and force remove any Python installations if needed."
Write-Host ""
# Prompt to download Geek Uninstaller
$downloadGeek = Read-Host "Are you like to download and run Geek Uninstaller Portable? in this moment? (y/n)"
if ($downloadGeek.ToLower() -eq 'y') {
    Write-Host ""
    Write-Host "Downloading Geek Uninstaller Portable..."
    try {
        # Download the .7z file
        Invoke-WebRequest -Uri $geekUninstallerUrl -OutFile $geekUninstallerPath
        Write-Host "Download complete."
        Start-Sleep -Seconds 1

        # Decompress the .7z file using 7-Zip
        Write-Host "Decompressing Geek Uninstaller..."
        try {
            # Check if 7-Zip is installed
            if (Test-Path $sevenZipPath) {
                & $sevenZipPath x $geekUninstallerPath -y | Out-Null # Extract to $scriptDir
                Write-Host "Decompression complete."
            } else {
                Write-Host "7-Zip is not installed. Please install 7-Zip to extract the file."
                Write-Host "You should not see this error because I decided not to bother with 7z"
                Write-Host "No one should ever see this. If you do. Something is fucked somewhere"
                exit
            }
        } catch {
            Write-Host "Failed to decompress Geek Uninstaller: $_. Please try again later."
            exit
        }

        # Define the path to geek.exe
        $geekExePath = Join-Path $scriptDir "geek.exe"  # Adjusted for clarity
        if (Test-Path $geekExePath) {
            # Launch geek.exe
            Start-Process $geekExePath
            Read-Host "Press Enter to continue after using Geek Uninstaller..."
        } else {
            Write-Host "geek.exe not found after decompression."
            exit
        }
    } catch {
        Write-Host "Failed to download Geek Uninstaller. Please play again later."
        exit
    }
} else {
    Write-Host "You have chosen to not do. this is ok. will proceed to not download."
    Write-Host ""
    Start-Sleep -Seconds 2
}

# Define common paths where Python might be installed
$commonPaths = @(
    "$env:ProgramFiles\Python*",
    "$env:ProgramFiles(x86)\Python*",
    "$env:LOCALAPPDATA\Programs\Python*",
    "$env:USERPROFILE\.pyenv"
)

# Function to check if Python is in the PATH
function Check-PythonInPath {
    $pathDirs = $env:PATH -split ';'
    $pythonPaths = @()
    foreach ($dir in $pathDirs) {
        if (Test-Path (Join-Path $dir "python.exe")) {
            $pythonPaths += (Join-Path $dir "python.exe")
        }
    }
    return $pythonPaths
}

# Check for Python installations in common paths
function Check-PythonInstallations {
    $foundPaths = @()
    foreach ($path in $commonPaths) {
        $matches = Get-Item -Path $path -ErrorAction SilentlyContinue
        if ($matches) {
            $foundPaths += $matches.FullName
        }
    }
    return $foundPaths
}

# Detect Python installations
$pythonInPath = Check-PythonInPath
$pythonInstallations = Check-PythonInstallations

# Inform the user about detected installations
if ($pythonInstallations.Count -eq 0 -and $pythonInPath.Count -eq 0) {
    Write-Host "No Python installations found."
    Write-Host "There still could be pieces of Python."
} else {
    Write-Host ""
    Write-Host "-- Python Installations Detected --" -BackgroundColor White
    foreach ($path in $pythonInstallations) {
        Write-Host " - $path"
    }
    foreach ($path in $pythonInPath) {
        Write-Host " - $path (in PATH)"
    }
}

# Prompt user to continue
Write-Host ""
$confirmation = Read-Host "Do you want to start the cleanup process at this moment? (y/n)"
if ($confirmation.ToLower() -ne 'y') {
    Write-Host "Cleanup abortion by user."
    exit
}

# Paths to clean up
$pathsToRemove = @(
    "$env:ProgramFiles\Python*",
    "$env:ProgramFiles(x86)\Python*",
    "$env:LOCALAPPDATA\Programs\Python*",
    "$env:LOCALAPPDATA\Programs\Python\Python39",
    "$env:LOCALAPPDATA\Programs\Python\Python38",
    "$env:LOCALAPPDATA\Programs\Python\Scripts",
    "$env:LOCALAPPDATA\Programs\Python\Lib",
    "$env:LOCALAPPDATA\Programs\Python\bin",
    "$env:USERPROFILE\.pyenv"
)

# Remove directories
Write-Host "-- Removal Process Start --"
foreach ($path in $pathsToRemove) {
    if (Test-Path $path) {
        Write-Host "Removing $path"
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $path
        Write-Host "Removed $path"
    } else {
        Write-Host "$path does not exist"
    }
}

# Function to remove environment variable
function Remove-EnvironmentVariable {
    param (
        [string]$name,
        [switch]$user
    )
    if ($user) {
        [System.Environment]::SetEnvironmentVariable($name, $null, [System.EnvironmentVariableTarget]::User)
        Write-Host "Removed user environment variable: $name"
    } else {
        [System.Environment]::SetEnvironmentVariable($name, $null, [System.EnvironmentVariableTarget]::Machine)
        Write-Host "Removed system environment variable: $name"
    }
}

# Remove Python environment variables from User and System variables
$envVarsToRemove = @("PYTHONPATH", "PYTHONHOME")

foreach ($envVar in $envVarsToRemove) {
    Remove-EnvironmentVariable -name $envVar -user
    Remove-EnvironmentVariable -name $envVar
}

# Clean up PATH variable entries for User and System variables
function Clean-Path {
    param (
        [switch]$user
    )
    $target = [System.EnvironmentVariableTarget]::Machine
    if ($user) {
        $target = [System.EnvironmentVariableTarget]::User
    }

    $path = [System.Environment]::GetEnvironmentVariable("Path", $target)
    if ($path) {
        $newPath = ($path -split ";") -notmatch "Python"
        [System.Environment]::SetEnvironmentVariable("Path", ($newPath -join ";"), $target)
        Write-Host "Cleaned PATH variable for $target"
    }
}

Clean-Path -user
Clean-Path

Write-Host ""
Write-Host "Cleanup complete. Please restart your computer to apply the changes."
Write-Host "Remember please restart"
$confirmation = Read-Host "Would you intent to restart with windows now? (y/n)"
if ($confirmation.ToLower() -ne 'y') {
    Write-Host "No restart."
    Write-Host "kthxbye"
    exit
}
Reboot-System
