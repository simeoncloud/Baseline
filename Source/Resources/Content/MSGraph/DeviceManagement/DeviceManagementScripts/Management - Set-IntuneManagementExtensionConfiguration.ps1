# Disables recycling of scripts by management extension - makes it easier to troubleshoot
# logs are under C:\Program Files (x86)\Microsoft Intune Management Extension\Content and Policies
$pf = ${env:ProgramFiles(x86)}
if (!$pf) { $pf = $env:ProgramFiles }
$path = Join-Path $pf 'Microsoft Intune Management Extension\Microsoft.Management.Services.IntuneWindowsAgent.exe.config'
$xml = [xml](gc $path -Raw)
$xml.configuration.appSettings.add |? { $_.key -eq 'recycleScripts' } |% { 
    if ($_.value -ne 'false') {
        $_.value = 'false' 
        $xml.Save($path)
        Restart-Service IntuneManagementExtension
        Write-Host "Updated IntuneManagementExtension recycleScripts setting to false and restarted service."
    } else {
        Write-Host "IntuneManagementExtension recycleScripts is already set to false."
    }
}
