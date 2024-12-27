$inputData = Get-Content -Path "$PSScriptRoot\input.txt"


$arrayLeft = @()
$arrayRight = @()
foreach ($line in $inputData) {
    $split = $line -replace "  ", "_"
    $arrayLeft += [int](($split -split "_")[0].Trim())
    $arrayRight += [int](($split -split "_")[1].Trim())
} 

$total = 0
for ($i = 0; $i -le $arrayLeft.Count; $i++) {
    $matched = 0
    foreach ($j in $arrayRight) {
        if ($arrayLeft[$i] -eq $j) {
            $matched++
        }
    }
    $total += [int]($arrayLeft[$i] * $matched)
}

$total