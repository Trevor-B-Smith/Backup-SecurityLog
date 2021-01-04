# Backup-SecurityLog
Powershell script to backup and read windows security logs

# You MUST run Powershell in ADMIN mode for these scripts to work!

### To install: 
- Download Zip file 
- Open Powershell and run `$env:PSModulePath`
- Export the zip file to the directory displayed, this is your device's module path, it should go inside a directory labeled `Modules`
- Make sure directory name is `Backup-SecurityLog`

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