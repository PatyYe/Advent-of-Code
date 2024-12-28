$inputData = Get-Content -Path "$PSScriptRoot\input.txt"

# Making a grid to search through
$guardPositions = "^", ">", "<", "v"
$grid = @()
foreach ($line in $inputData) {
    $grid += $line
}

$posRow = 0
$posCol = 0
for ($row=0; $row -lt $grid.Length; $row++) {
    for ($col=0; $col -lt $grid[0].Length; $col++) {
        if ($guardPositions -contains $grid[$row][$col]) {
            $posRow = $row; $posCol = $col;
        }
    }
}

$steps = 0
$turns = 0
$exitFound = $false
$row = $posRow
$col = $posCol
while (!$exitFound) {
    try {
        if ($grid[$row][$col] -eq "^") {
            if ($row-1 -lt 0) {
                $exitFound = $true
                break;
            }
            if ($grid[$row-1][$col] -eq "#") { 
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col] = ">"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $turns++
            }
            else {
                if ($grid[$row-1][$col] -eq '.') { $steps++ }
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col] = "X"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $grid[$row-1] = $grid[$row-1].ToCharArray()
                $grid[$row-1][$col] = "^"
                $grid[$row-1] = -join $grid[$row-1]  # Convert back to string
                $row -= 1
            }
        } elseif ($grid[$row][$col] -eq ">") {
            if ($col+1 -eq $grid[0].Length) {
                $exitFound = $true
                break;
            }
            if ($grid[$row][$col+1] -eq "#") { 
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col] = "v"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $turns++
            }
            else {
                if ($grid[$row][$col+1] -eq '.') { $steps++ }
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col] = "X"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col+1] = ">"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $col += 1
            }
        } elseif ($grid[$row][$col] -eq "v") {
            if ($row+1 -eq $grid.Length) {
                $exitFound = $true
                break;
            }
            if ($grid[$row+1][$col] -eq "#") { 
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col] = "<"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $turns++
            } else {
                if ($grid[$row+1][$col] -eq '.') { $steps++ }
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col] = "X"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $grid[$row+1] = $grid[$row+1].ToCharArray()
                $grid[$row+1][$col] = "v"
                $grid[$row+1] = -join $grid[$row+1]  # Convert back to string
                $row += 1
            }
        } elseif ($grid[$row][$col] -eq "<") {
            if ($col-1 -lt 0) {
                $exitFound = $true
                break;
            }
            if ($grid[$row][$col-1] -eq "#") { 
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col] = "^"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $turns++
            }
            else {
                if ($grid[$row][$col-1] -eq ".") { $steps++ }
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col] = "X"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $grid[$row] = $grid[$row].ToCharArray()
                $grid[$row][$col-1] = "<"
                $grid[$row] = -join $grid[$row]  # Convert back to string
                $col -= 1
            }
        }
    } catch {
        exit
    }
}
$steps+1