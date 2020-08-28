Start-Transcript "$env:temp\Set-TimeZone.ps1.log" -Append -IncludeInvocationHeader

# some computers have issues using Auto Time Zone Updater because of ISP or network restrictions; set the default time zone just in case
$ianaZone = Invoke-RestMethod 'http://worldtimeapi.org/api/ip' | Select -ExpandProperty timezone
Write-Host "IANA time zone for current IP is $ianaZone."
if (!(Test-Path $env:temp\TimeZoneConverter\TimeZoneConverter\lib\net461\TimeZoneConverter.dll)) {
    Write-Host "Installing TimeZoneConverter library."
    Install-Package TimeZoneConverter -RequiredVersion 3.2.0 -Destination $env:temp\TimeZoneConverter -Force -ProviderName NuGet -Source  https://www.nuget.org/api/v2 -ExcludeVersion -SkipDependencies | Out-Null
}
[System.Reflection.Assembly]::LoadFrom("$env:temp\TimeZoneConverter\TimeZoneConverter\lib\net461\TimeZoneConverter.dll") | Out-Null
$windowsZone = [TimeZoneConverter.TZConvert]::IanaToWindows($ianaZone)
Write-Host "Setting time zone to $windowsZone."
Set-TimeZone $windowsZone

Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate -Name Start -Value 3 # enable Auto Time Zone Updater
Set-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location -Name VALUE -Value "Allow" # enable location services for device (required for Auto Time Zone Updater)

$('W32Time', 'tzautoupdate') |% { Start-Service $_ -EA SilentlyContinue; Restart-Service $_ -EA SilentlyContinue }

Stop-Transcript