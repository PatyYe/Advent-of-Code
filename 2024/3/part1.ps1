Clear-Host
$inputData = Get-Content -Path "$PSScriptRoot\input.txt"

$parts = $inputData -split "mul\("

$total = 0
foreach ($p in $parts) {
    if ($p -match "\)") {
        $calculation = ($p -split "\)")[0]
        $calc = $calculation -split ","
        try {
            $add = ([int]$calc[0] * [int]$calc[1])
            $total += $add
        } catch { 
            # $calculation
        }
    }
}

$total