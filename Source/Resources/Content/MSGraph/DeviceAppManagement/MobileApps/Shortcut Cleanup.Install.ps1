$ErrorActionPreference = 'Stop'

$block = {
    $ErrorActionPreference = 'Stop'

    Start-Transcript "$($env:TEMP)/Remove-DuplicateShortcuts.log" -Append -IncludeInvocationHeader

    $desktop = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)
    (@(gci $desktop -Filter '* - Copy.lnk') + @(gci $desktop -Filter '* - Copy (*).lnk')) |? { Test-Path ($_.FullName -replace ' - Copy( \(\d+\))?\.lnk', '.lnk') } |% { 
        Write-Host "Removing $_."
        $_ | Remove-Item -Force
    }

	Stop-Transcript
}

$scriptName = 'Remove-DuplicateShortcuts'
($managementScripts = "$env:ProgramData\ManagementScripts") |% { $scriptPath = "$_\$scriptName.ps1" }
md $managementScripts -EA SilentlyContinue | Out-Null
sc $scriptPath $block -NoNewline -Force | Out-Null

$vbs = "$($scriptPath).vbs"
@"
command = "powershell.exe -ExecutionPolicy Bypass -NoProfile -NonInteractive -WindowStyle Hidden ""$scriptPath"""
set shell = CreateObject("WScript.Shell")
shell.Run command,0
"@ | sc $vbs

$taskPath = "\ManagementScripts\"

# remove obsolete
Unregister-ScheduledTask -TaskName $scriptName -TaskPath $taskPath -Confirm:$false -EA SilentlyContinue

# Register as a scheduled task to run as the currently logged on user (by assigning it to group Users) at user logon
Register-ScheduledTask -TaskName $scriptName -TaskPath $taskPath `
    -Principal (New-ScheduledTaskPrincipal -GroupId 'BUILTIN\Users' -RunLevel Limited) `
    -Trigger @((New-ScheduledTaskTrigger -AtStartup), (New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 30))) `
    -Action (New-ScheduledTaskAction -Execute 'wscript.exe' -Argument $vbs -WorkingDirectory $managementScripts) `
    -Settings (New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries) -Force `
    | Out-Null

Start-ScheduledTask -TaskName $scriptName -TaskPath $taskPath

Write-Host "Installation completed."