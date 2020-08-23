param (
    $BaselineDirectory = "$PSSCriptRoot"
)
function Resolve-RelativePath([string]$Path, [string]$RelativeTo) {

    Push-Location $RelativeTo
    try {
        Resolve-Path -Path $Path -Relative
    }
    finally {
        Pop-Location
    }
}

$descriptions = @()
Write-Host "Getting files from baseline directory $baselineDirectory"
Get-ChildItem -Path $BaselineDirectory -Filter "*.json" -Recurse -File | ForEach-Object {
    $file =  $_.FullName
    Write-Host "Reading file $_"
    $fileContent = Get-Content -Path $file | ConvertFrom-Json -Depth 100
    if ($fileContent.Description){
        $descriptions += @{
            relativeSource = Resolve-RelativePath -Path $file -RelativeTo "$baselineDirectory\Source\Resources\Content"
            description = $fileContent.Description.Trim()
        }    
    }
    else {
        Write-Warning "File $file does not have a descrption"
    }
}

Write-Host "Building markdown file"

$stringContent ="# Simeon Baseline"
$descriptions | ForEach-Object {
    $stringContent = "$stringContent `n ## $($_.relativeSource) `n$($_.description) `n"
}

$stringContent | Out-File $BaselineDirectory\SimeonBaseline.md