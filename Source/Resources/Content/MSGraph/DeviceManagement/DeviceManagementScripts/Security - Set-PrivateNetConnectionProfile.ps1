$ErrorActionPreference = 'Stop'

$block = {
    param([switch]$NoTranscript)

    $ErrorActionPreference = 'Stop'

    if (!$NoTranscript) { Start-Transcript "$($MyInvocation.MyCommand.Path).$((Get-Date).ToString('yyyy-MM')).log" -Append -IncludeInvocationHeader }

    if ($env:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
        Write-Warning "PowerShell 32 bit detected on 64 bit Windows - re-running in 64 bit PowerShell"
        & "$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile -ExecutionPolicy Bypass -File $PSCommandPath -NoTranscript | Out-Host
        return
    }
    # Sets the network profile to private if the interface matches one of the specified networks
    Get-NetConnectionProfile | 
        Where-Object { $_.InterfaceAlias -in $privateNetworks -and $_.NetworkCategory -ne 'Private' } | 
        ForEach-Object {
            $networkProfile = $_
            Write-Host "Network $($networkProfile.Name) (Alias $($networkProfile.InterfaceAlias)) has NetworkCategory $($networkProfile.NetworkCategory). Changing to Private..."
            Set-NetConnectionProfile -Name $networkProfile.Name -NetworkCategory Private
        }
    Write-Host "Finished updating network connection profiles."
}

$scriptName = 'Set-PrivateNetConnectionProfile'
($managementScripts = "$env:ProgramData\ManagementScripts") |% { $scriptPath = "$_\$scriptName.ps1" }
md $managementScripts -EA SilentlyContinue | Out-Null
sc $scriptPath $block -NoNewLine
$psArgs = "-ExecutionPolicy Bypass -NoProfile -NonInteractive -WindowStyle Hidden -File `"$scriptPath`""

$taskPath = "\ManagementScripts\"

Register-ScheduledTask -TaskName $scriptName -TaskPath ManagementScripts -Principal (New-ScheduledTaskPrincipal SYSTEM -LogonType ServiceAccount -RunLevel Highest) `
    -Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 3)) `
    -Action (New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $psArgs) `
	-Settings (New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries) -Force `
    | Out-Null

Start-ScheduledTask -TaskName $scriptName -TaskPath $taskPath