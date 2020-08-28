$ErrorActionPreference = 'Stop'

$block = {

    $ErrorActionPreference = 'Stop'
	$accountName = 'devicelocaladmin'

    Start-Transcript "$($MyInvocation.MyCommand.Path).$((Get-Date).ToString('yyyy-MM')).log" -Append -IncludeInvocationHeader

	try {
		$pw = Get-BitLockerVolume -MountPoint C: |% { $_.KeyProtector.RecoveryPassword } |? { $_ } | Select -Last 1
		if ($pw) { 
			$pw = (($pw -split '-' | Select-Object -First 3) -join '-') + 'X' #Take the first 3 sextets of the key and add a capital letter to pass complexity requirements (those could not be disabled for local accounts)
			Write-Host "Using BitLocker key starting in *$($pw.Substring(0,6)) for password." 
		}
	} 
	catch {
	}
	if (!$pw) {
		# if there is no BitLocker password or an exception is thrown
		Write-Host "BitLocker key not available. Skipping this execution."
		return
	}

    $encryptedPassword = ConvertTo-SecureString $pw -AsPlainText -Force

	$user = get-localuser -Name $accountName -ErrorAction SilentlyContinue
	if (!$user) {
	    Write-Host "Creating local user $accountName."
		$user = New-LocalUser -Name $accountName -FullName $accountName `
			-AccountNeverExpires `
			-Description 'Device local computer admin account' `
			-PasswordNeverExpires -UserMayNotChangePassword -Password $encryptedPassword
	}

	# Normally we'd use the Get-LocalGroupMember commandlet, but due to bug https://github.com/PowerShell/PowerShell/issues/2996 we're using an alternate way to get the group membership
	$memberOfLocalAdmins = ([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]$_).InvokeGet('AdsPath')} | ? { $_.EndsWith("$($env:COMPUTERNAME)/$accountName")}
	if (!$memberOfLocalAdmins) {
		Write-Host "Adding $accountName to local Administrators group."
		Add-LocalGroupMember -Group 'Administrators' -Member $user
	}
    
    # Make sure the password is the expected one and reset it if not
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement
    $ds = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('machine',$env:COMPUTERNAME)
    if (!$ds.ValidateCredentials($accountName, $pw)) {
		Write-Host "$accountName's password doesn't match expected; resetting password."
        $user | Set-LocalUser -PasswordNeverExpires:$true -Password $encryptedPassword
    }
    $ds.Dispose()

    Write-Host "Done configuring local administrator user $accountName."

	Stop-Transcript
}

$scriptName = 'Set-LocalAdminPassword'
($managementScripts = "$env:ProgramData\ManagementScripts") |% { $scriptPath = "$_\$scriptName.ps1" }
md $managementScripts -EA SilentlyContinue | Out-Null
sc $scriptPath $block -NoNewline
$psArgs = "-ExecutionPolicy Bypass -NoProfile -NonInteractive -WindowStyle Hidden -File `"$scriptPath`""

$taskPath = "\ManagementScripts\"

Register-ScheduledTask -TaskName $scriptName -TaskPath ManagementScripts -Principal (New-ScheduledTaskPrincipal SYSTEM -LogonType ServiceAccount -RunLevel Highest) `
    -Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 30)) `
    -Action (New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $psArgs) `
	-Settings (New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries) -Force `
    | Out-Null
	
Start-ScheduledTask -TaskName $scriptName -TaskPath $taskPath