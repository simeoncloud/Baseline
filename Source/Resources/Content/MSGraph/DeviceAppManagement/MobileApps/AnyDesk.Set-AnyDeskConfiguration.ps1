$ErrorActionPreference = 'Stop'

Start-Transcript "$($MyInvocation.MyCommand.Path).$((Get-Date).ToString('yyyy-MM')).log" -Append -IncludeInvocationHeader

$app = (@(${env:ProgramFiles(x86)}, $env:ProgramFiles) | ? { $_ } | % { gci "$_\AnyDesk-*_msi" }) | % { gci $_ *.exe -Recurse } | Select -First 1 -ExpandProperty FullName

# Find the system.conf file for the latest app install folder (in case a prior version's folder is still present)
$config = gci $env:ProgramData\AnyDesk system.conf -Recurse -EA SilentlyContinue | Sort -Descending { $_.Directory.CreationTimeUtc } | Select -First 1
if ($config) { 
    $alias = gc $config.FullName | ? { $_ -like "ad.anynet.alias=*" } | % { $_.Split('=')[1] }
	# AnyDesk will add -nnn to a duplicate computer name, so verify if the current name matches itself, or itself-nnn
    if ($alias.Split('@')[0] -notmatch "^$($env:COMPUTERNAME.ToLower())(-[0-9]+){0,1}`$") {
        Write-Host "Removing system.conf and service.conf to resynchronize alias with computer name."
        Move-Item $config.FullName "$config.bak" -Force
        Move-Item (Join-Path $config.DirectoryName service.conf) "$config.bak" -Force
        & $app '--restart-service'
    }
}

try {
    $pw = Get-BitLockerVolume -MountPoint C: | % { $_.KeyProtector.RecoveryPassword } | ? { $_ } | Select -Last 1
    if ($pw) {
        $pw = (($pw -split '-' | Select-Object -First 3) -join '-') + 'X'  #Take the first 3 sextets of the key and add a capital letter to pass complexity requirements (can not be disabled for only this account)
        Write-Host "Using BitLocker key starting in *$($pw.Substring(0,6)) for AnyDesk password." 
    }
} 
catch {
}
if (!$pw) {
    # if there is no BitLocker password or an exception is thrown
    $pw = gc "$($MyInvocation.MyCommand.Path).default.dat" -Raw | ConvertTo-SecureString | % { "$([pscredential]::new('null', $_).GetNetworkCredential().Password)$($env:COMPUTERNAME.ToLower())" }		
    Write-Host "Using default password."
}

$pw | & $app '--set-password'
Write-Host "Done setting AnyDesk password."

Write-Host "Ensuring AnyDesk service is started."
& $app '--start-service'

Stop-Transcript