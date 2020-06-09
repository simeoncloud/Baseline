$ErrorActionPreference = 'Stop'

if ($env:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
    Write-Host "Re-launching PowerShell in 64 bit."
    if ($MyInvocation.Line) {
        & "$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile -ExecutionPolicy Bypass $MyInvocation.Line
    }
    else {
        &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile -ExecutionPolicy Bypass -File "$($MyInvocation.InvocationName)" $args
    }
    exit $lastexitcode
}

Write-Progress "Installing Microsoft Windows Virtual Desktop Client (do not close window)"
Write-Host "Downloading msi."
Invoke-RestMethod 'https://aka.ms/wvdclient' -OutFile $env:temp\wvd.msi
Write-Host "Installing msi."
Start-Process "msiexec.exe" -ArgumentList @("/i", "$env:temp\wvd.msi", "/qn", "ALLUSERS=1", "MSIINSTALLPERUSER=`"`"", "/l*v", "$env:temp\wvdinstall.log") -NoNewWindow -Wait
gc "$env:temp\wvdinstall.log" -Raw -EA SilentlyContinue | Out-Host
if (!(Test-Path "$env:ProgramFiles\Remote Desktop\msrdcw.exe")) { throw "Installation failed." }
Write-Host "Installation completed."