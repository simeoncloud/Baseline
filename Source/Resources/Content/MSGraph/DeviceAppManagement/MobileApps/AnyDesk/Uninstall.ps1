Write-Host "Uninstalling msi."
Start-Process msiexec -Wait -ArgumentList '/qn /x {C51D4267-8B44-47A9-B67F-4237868E2275}'

Write-Host "Unregistering configuration task."
Unregister-ScheduledTask -TaskName Set-AnyDeskConfiguration -TaskPath \ManagementScripts\ -Confirm:$false -EA SilentlyContinue

Write-Host "Removing installation files."
Remove-Item $env:ProgramData\AnyDesk -Recurse -Force

Write-Host "Uninstall completed."