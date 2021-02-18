function Backup-SecurityLog {
    $directoryLocation = "C:\Windows\System32\SecurityLogsBackup"
    $directoryExists = Test-Path $directoryLocation -PathType Container
    if (-NOT($directoryExists)) {
        Write-Host("Created new directory for Security Logs at $directoryLocation")
        New-Item -ItemType directory -Path C:\Windows\System32\SecurityLogsBackup
    }
    $ISODate = Get-Date -format 'yyyy-MM-dd_h-mm-ss'
    $log = Get-WmiObject -Class Win32_NTEventlogFile | Where-Object LogfileName -EQ 'security'
    $log.BackupEventlog('C:\Windows\System32\SecurityLogsBackup\securityBackup'+$ISODate+'.evtx')
} 

function Read-SecurityLog {
    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [Switch]
        $Help = $false,

        [ValidateNotNullOrEmpty()]
        [Switch]
        $FailOnly = $false,

        [ValidateNotNullOrEmpty()]
        [Switch]
        $SuccessOnly = $false,

        [ValidateNotNullOrEmpty()]
        [String[]]
        $Id = 'Standard'
    )

    PROCESS {
        if ($Help) {
            Show-SecurityHelp
            return
        }
        if ($Id -eq 'Standard') {
            #Edit this later
            $Id = '4624','4625','5061'
        }
        if ($Id -eq 'All') {
            if ($FailOnly) {
                try {
                    Get-WinEvent -FilterHashtable @{LogName='Security';Keywords='4503599627370496'} | Out-Host -Paging
                } catch {
                    Write-Error("ID $Id is not valid. Try 'Read-SecurityLog -Help'")
                }
            } elseif ($SuccessOnly) {
                try {
                    Get-WinEvent -FilterHashtable @{LogName='Security';Keywords='9007199254740992'} | Out-Host -Paging
                } catch {
                    Write-Error("ID $Id is not valid. Try 'Read-SecurityLog -Help'")
                }
            } else {
                    Get-WinEvent -FilterHashtable @{LogName='Security'} | Out-Host -Paging
            }
        } else {
            if ($FailOnly) {
                try {
                    Get-WinEvent -FilterHashtable @{LogName='Security';ID=$Id;Keywords='4503599627370496'} | Out-Host -Paging
                } catch {
                    Write-Error("ID $Id is not valid. Try 'Read-SecurityLog -Help'")
                }
            } elseif ($SuccessOnly) {
                try {
                    Get-WinEvent -FilterHashtable @{LogName='Security';ID=$Id;Keywords='9007199254740992'} | Out-Host -Paging
                } catch {
                    Write-Error("ID $Id is not valid. Try 'Read-SecurityLog -Help'")
                }
            } else {
                Get-WinEvent -FilterHashtable @{LogName='Security';ID=$Id} | Out-Host -Paging
            }
        }
    }
}

function Show-SecurityHelp {
    Write-Host("Read-SecurityLog is a function that reads through the events in the Windows Security Log.")
    Write-Host("Parameters include:")
    Write-Host("-FailOnly (Switch)     | Only view Failed events")
    Write-Host("-SuccessOnly (Switch)  | Only View Successful Events")
    Write-Host("-Id (String)           | List of IDs to read. Defaults to 'Standard' Other options include 'All' or an array of IDs such as '4624','4625','5061'")
    Write-Host("-Help (Switch)         | Show this menu")
    Write-Host("`nExamples:")
    Write-Host("Read-SecurityLog -FailOnly -Id '4624'")
    Write-Host("Read-SecurityLog -SuccessOnly")
    Write-Host("Read-SecurityLog -Id 'All'")
}