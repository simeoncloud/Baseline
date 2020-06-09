$ErrorActionPreference = 'Stop'

Write-Host "Installing AnyDesk msi."
Start-Process msiexec -Wait -ArgumentList "/i `"$PSScriptRoot\AnyDesk.msi`" /qn /l*v `"$PSScriptRoot/install.log`""
gc $PSScriptRoot/install.log -Raw -EA SilentlyContinue | Out-Host

# remove obsolete
Remove-Item "$env:ProgramData\ManagementScripts\Set-AnyDeskPassword.*" -Force -EA SilentlyContinue

$programData = "$env:ProgramData\AnyDesk"
$scriptName = "Set-AnyDeskConfiguration"
$taskPath = "\ManagementScripts\"

Write-Host "Writing files to ProgramData." 
sc "$programData\$scriptName.ps1.default.dat" (ConvertTo-SecureString "@nyD3sk" -AsPlainText -Force | ConvertFrom-SecureString) -NoNewline
Copy-Item $PSScriptRoot/$scriptName.ps1 $programData -Force | Out-Null
Copy-Item $PSScriptRoot/Uninstall.ps1 $programData -Force | Out-Null

# remove obsolete
Unregister-ScheduledTask -TaskName Set-AnyDeskPassword -TaskPath $taskPath -Confirm:$false -EA SilentlyContinue

Write-Host "Registering configuration task."
Register-ScheduledTask -TaskName $scriptName -TaskPath $taskPath -Principal (New-ScheduledTaskPrincipal SYSTEM -LogonType ServiceAccount -RunLevel Highest) `
    -Trigger @((New-ScheduledTaskTrigger -AtStartup), (New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 30))) `
    -Action (New-ScheduledTaskAction -Execute 'powershell.exe' -Argument  "-ExecutionPolicy Bypass -NoProfile -NonInteractive -WindowStyle Hidden -File `"$programData\$scriptName.ps1`"") `
    -Settings (New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries) -Force `
| Out-Null

Write-Host "Starting configuration task."
Start-ScheduledTask -TaskName $scriptName -TaskPath $taskPath

Write-Host "Install completed."