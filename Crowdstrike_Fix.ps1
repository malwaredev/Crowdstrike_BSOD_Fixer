# PowerShell script to delete C-00000291*.sys file from CrowdStrike folder

# Define log file path
$logFile = "C:\temp\DeleteCSFileLog.txt"

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath $logFile
}

# Check if the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script must be run as an administrator."
    Log-Message "Script not run as administrator."
    exit
}

# Check the current execution policy
$currentPolicy = Get-ExecutionPolicy
Write-Host "Current Execution Policy: $currentPolicy"
Log-Message "Current Execution Policy: $currentPolicy"
Write-Host "Setting execution policy to Bypass for this session..."

# Set the execution policy to allow script execution for this session
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    Log-Message "Execution policy set to Bypass."
} catch {
    Write-Host "Failed to set execution policy. Error: $($_.Exception.Message)"
    Log-Message "Failed to set execution policy. Error: $($_.Exception.Message)"
    exit
}

# Set the path to the CrowdStrike drivers folder
$csPath = "C:\Windows\System32\drivers\CrowdStrike"

# Check if the folder exists
if (-not (Test-Path $csPath)) {
    Write-Host "CrowdStrike folder not found."
    Log-Message "CrowdStrike folder not found."
    exit
}

# Change to the CrowdStrike folder
Set-Location $csPath

# Confirm deletion with the user
$confirmation = Read-Host "Are you sure you want to delete C-00000291*.sys? (Y/N)"
if ($confirmation -ne 'Y' -and $confirmation -ne 'y') {
    Write-Host "Deletion canceled by user."
    Log-Message "Deletion canceled by user."
    exit
}

# Try to delete the file(s)
Write-Host "Attempting to delete C-00000291*.sys file(s)..."
try {
    $files = Get-ChildItem -Path "C-00000291*.sys"
    if ($files.Count -eq 0) {
        Write-Host "No files matching the pattern were found."
        Log-Message "No files matching the pattern were found."
    } else {
        foreach ($file in $files) {
            Remove-Item -Path $file.FullName -Force -ErrorAction Stop
            Write-Host "File successfully deleted: $($file.FullName)"
            Log-Message "File successfully deleted: $($file.FullName)"
        }
    }
} catch {
    Write-Host "Unable to delete file(s). It may be in use or require elevated permissions."
    Write-Host "Error: $($_.Exception.Message)"
    Log-Message "Unable to delete file(s). Error: $($_.Exception.Message)"
}

# Final exit message
Write-Host "Script execution completed."
Log-Message "Script execution completed."

# Keep the window open
Read-Host -Prompt "Press Enter to exit"
