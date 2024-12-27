Clear-Host
$inputData = Get-Content -Path "$PSScriptRoot\input.txt"

$safeReports = 0
foreach ($line in $inputData) {
    $data = ($line -split " ")
    
    $keepTrack = 0
    $increasing = $false
    $safe = $true
    foreach ($i in $data) {
        if ($keepTrack -eq ($data.Count - 1)) { continue; } # lastdigit
        if (-not $safe) { continue; } # we are not safe anymore, skip other checks.
        # Figure out if we are increasing first 2 digits..
        if ($keepTrack -eq 0 -and ([int]$i) -lt ([int]$data[($keepTrack + 1)])) {
            $increasing = $true
        }
        # Calculate the difference between first 2
        $diff = ([int]$i) - ([int]$data[($keepTrack + 1)])

        if ($diff -eq 0) { # we need a difference..
            $safe = $false
        } elseif ($diff -lt 0 -and $increasing) { # we are increasing because we are negative
            $pos = -$diff
            if ($pos -gt 3 -or $pos -lt 1) { $safe = $false }
        } elseif ($diff -gt 0 -and -not $increasing) {  # we are decreasing so our diff is positive
            if ($diff -gt 3 -or $diff -lt 1) { $safe = $false }
        } else { # assume we are in a negative value..
            $safe = $false
        }
        $keepTrack++
    }
    if ($safe) { $safeReports++ }
}

$safeReports