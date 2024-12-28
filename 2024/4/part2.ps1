Clear-Host
$inputData = Get-Content -Path "$PSScriptRoot\input.txt"

# Making a grid to search through
$grid = @()
foreach ($line in $inputData) {
    $grid += $line
}

$totalMatches = 0
for ($row = 0; $row -lt $grid.Length; $row++) { # Looping Through all Rows
    for ($col = 0; $col -lt $grid[0].Length; $col++) { # Using every column
        if ($row-1 -ge 0 -and $col-1 -ge 0 -and $row+1 -lt $grid.Length -and $col+1 -lt $grid[0].Length) {
            if ($grid[$row][$col] -eq "A") {
                $ul = $grid[$row-1][$col-1]
                $dr = $grid[$row+1][$col+1]
                $ur = $grid[$row-1][$col+1]
                $dl = $grid[$row+1][$col-1]

                if ((($ul -eq "M" -and $dr -eq "S") -or ($ul -eq "S" -and $dr -eq "M")) `
                    -and `
                    (($ur -eq "M" -and $dl -eq "S") -or ($ur -eq "S" -and $dl -eq "M"))) 
                    {
                        # Write-Host 'A at [' $row ',' $col '] is a middle of a proper X-MAS'
                        # Write-Host $ul
                        # Write-Host $dr
                        # Write-Host "---"
                        # Write-Host $ur
                        # Write-Host $dl
                        # Write-Host "==="
                        $totalMatches++
                }
            }
        }
    }
}

$totalMatches