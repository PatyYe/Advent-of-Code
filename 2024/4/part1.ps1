Clear-Host
$inputData = Get-Content -Path "$PSScriptRoot\input.txt"

# Making a grid to search through
$grid = @()
foreach ($line in $inputData) {
    $grid += $line
}

# Define the word to search
$word = "XMAS"

# Directions we can possibly find the word.
$directions = @(
    @{ Row = 0; Col = 1 },   # Right
    @{ Row = 1; Col = 0 },   # Down
    @{ Row = 0; Col = -1 },  # Left
    @{ Row = -1; Col = 0 },  # Up
    @{ Row = 1; Col = 1 },   # Down-right
    @{ Row = 1; Col = -1 },  # Down-left
    @{ Row = -1; Col = 1 },  # Up-right
    @{ Row = -1; Col = -1 }  # Up-left
)

# Logic to check if we hit the word within bounds.
function CheckWord() {
    param (
        $startRow, $startCol, $direction
    )
    for ($i = 0; $i -lt $word.Length; $i++) { # Checking for the worth length.
        $row = $startRow + ($i * $direction.Row) # Finding the row to look for.
        $col = $startCol + ($i * $direction.Col) # Finding the column to look for.

        # Check if we're not going out of bounds
        if ($row -lt 0 -or $row -ge $grid.Length -or $col -lt 0 -or $col -ge $grid[0].Length) {
            return $false
        }

        # Check if the letter we are looking for is on the row/column position we are looping over.
        if ($grid[$row][$col] -ne $word[$i]) {
            return $false
        }
    }
    return $true
}

# Main loop to search for the word
$totalMatches = 0
for ($row = 0; $row -lt $grid.Length; $row++) { # Looping Through all Rows
    for ($col = 0; $col -lt $grid[0].Length; $col++) { # Using every column
        foreach ($direction in $directions) { # Going into every possible direction
            if (CheckWord $row $col $direction) {
                $totalMatches++
            }
        }
    }
}

$totalMatches