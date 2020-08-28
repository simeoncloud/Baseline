$ErrorActionPreference = 'Stop'

$block = {

    $ErrorActionPreference = 'Stop'

    Start-Transcript "$($MyInvocation.MyCommand.Path).log" -Append -IncludeInvocationHeader

	$wmiObject = (Get-WmiObject -class Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'")
	if ($wmiObject -and $wmiObject.UserAuthenticationRequired -ne 0) {
	    Write-Host "UserAuthenticationRequired is $($wmiObject.UserAuthenticationRequired). Setting it to 0."
		$wmiObject.SetUserAuthenticationRequired(0) | Out-Null
	}
	$wmiObject.Dispose()

	Stop-Transcript
}

$scriptName = 'Set-NetworkLayerAuthentication'
($managementScripts = "$env:ProgramData\ManagementScripts") |% { $scriptPath = "$_\$scriptName.ps1" }
md $managementScripts -EA SilentlyContinue | Out-Null
sc $scriptPath $block -NoNewline
$psArgs = "-ExecutionPolicy Bypass -NoProfile -NonInteractive -WindowStyle Hidden -File `"$scriptPath`""

$taskPath = "\ManagementScripts\"

Register-ScheduledTask -TaskName $scriptName -TaskPath ManagementScripts -Principal (New-ScheduledTaskPrincipal SYSTEM -LogonType ServiceAccount -RunLevel Highest) `
    -Trigger (New-ScheduledTaskTrigger -AtStartup) `
    -Action (New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $psArgs) `
	-Settings (New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries) -Force `
    | Out-Null

Start-ScheduledTask -TaskName $scriptName -TaskPath $taskPath