# Crowdstrike_BSOD_Fixer

 Batch or PowerShell script designed to delete the C-00000291*.sys file(s) from the CrowdStrike drivers directory (C:\Windows\System32\drivers\CrowdStrike). This script is intended for use in troubleshooting scenarios where the specified file is causing system instability or related issues.
Features
Administrative Privileges Check: Ensures the script is run with the necessary permissions to modify system files.
Execution Policy Management: Temporarily sets the PowerShell execution policy to Bypass for the current session to allow script execution.
User Confirmation: Prompts the user for confirmation before proceeding with the deletion of the specified file(s).
Logging: Records actions and errors to a log file for future reference and troubleshooting.
Multiple File Handling: Safely handles the deletion of multiple files matching the specified pattern.
Usage
Save the script or download the script. 
Right-click the script file and select "Run with PowerShell as Administrator."
Follow the on-screen prompts to confirm the deletion.
Important Notes
Backup: It is highly recommended to back up your system or create a restore point before running this script, as it modifies system files.
Testing: The script has not been tested in all environments and scenarios. Use it at your own risk.
Author Disclaimer: The author of this script is not responsible for any issues that may arise from its use, including but not limited to data loss, system instability, or security vulnerabilities. 
