Clear-Host
$inputData = Get-Content -Path "$PSScriptRoot\input.txt"

$parts = $inputData -split "mul\("

$total = 0

$enabled = $true
for ($i=0; $i -lt $parts.Count; $i++) {
    if ($enabled) {
        # $parts[$i]
        if ($parts[$i] -match "\)") {
            $calculation = ($parts[$i] -split "\)")[0]
            $calc = $calculation -split ","
            try {
                $add = ([int]$calc[0] * [int]$calc[1])
                $total += $add
            } catch { 
                # $calculation
            }
        }
    }
    if ($parts[$i] -match "don't\(\)") {
        # Write-Host $parts[$i] -ForegroundColor Red
        $enabled = $false
    } elseif ($parts[$i] -match "do\(\)") {
        # Write-Host $parts[$i] -ForegroundColor Green
        $enabled = $true
    }
}

$total