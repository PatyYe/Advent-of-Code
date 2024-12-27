$inputData = Get-Content -Path "$PSScriptRoot\input.txt"


$arrayLeft = @()
$arrayRight = @()
foreach ($line in $inputData) {
    $split = $line -replace "  ", "_"
    $arrayLeft += (($split -split "_")[0].Trim())
    $arrayRight += (($split -split "_")[1].Trim())
}

$arrayLeft = $arrayLeft | Sort-Object 
$arrayRight = $arrayRight | Sort-Object 

$total = 0
for ($i = 0; $i -le $arrayLeft.Count; $i++) {
    $add = ($arrayLeft[$i] - $arrayRight[$i])
    if ($add -lt 0) {
        $add = -$add
    }
    $total += $add
}

$total