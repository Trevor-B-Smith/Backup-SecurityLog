# Backup-SecurityLog
Powershell script to backup and read windows security logs

# You MUST run Powershell in ADMIN mode for these scripts to work!

## To install: 
##### NOTE: you cannot simply pull this branch and run it since the code is unsigned.
- Open Powershell and run `$env:PSModulePath`
 * If this gives multiple directories, choose the one with System32
- Create a Directory named `Backup-SecurityLog` in the directory displayed, this is your device's module path, it should go inside a directory labeled `Modules`
- Move the file named `Backup-SecurityLog.psm1` into this directory, this is your script that will run (you may need admin priveleges to do this)
- Open Powershell and run `Import-Module Backup-SecurityLog`
- If you receive an error, run `Set-ExecutionPolicy Unrestricted` and try again
- WARNING: This allows any script to run and can leave a device vulnerable, when you have imported the module, run `Set-ExecutionPolicy AllSigned` to reinstate the security.

# Use Cases

## Backup-SecurityLog:
* No parameters
* Creates a directory in the path C:\Windows\System32 named 'SecurityLogsBackup'
* Stores a backup in this directory
* File naming format: 'securityBackupyyyy-MM-dd_hh-mm-s'

## Read-SecurityLog:
#### Read-SecurityLog is a function that reads through the events in the Windows Security Log.
#### Parameters include:
- `-FailOnly` (Switch)     | Only view Failed events
- `-SuccessOnly` (Switch)  | Only View Successful Events
- `-Id` (String)           | List of IDs to read. Defaults to 'Standard' Other options include 'All' or an array of IDs such as '4624','4625','5061'
- `-Help` (Switch)         | Show this menu

#### Examples:
- `Read-SecurityLog -FailOnly -Id '4624'`
- `Read-SecurityLog -SuccessOnly`
- `Read-SecurityLog -Id 'All'`