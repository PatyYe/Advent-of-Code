Clear-Host

Function Check-Safety {
    param($data)
    begin {
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
        return $safe
    }
}

$inputData = Get-Content -Path "$PSScriptRoot\input.txt"

$safeReports = 0
foreach ($line in $inputData) {
    $data = ($line -split " ")
    if (Check-Safety -data $data) { $safeReports++}
    else {
        $safetyCheckTwo = $false
        for ($i=0; $i -lt $data.Count; $i++) {
            if ($safetyCheckTwo) { continue; }
            $attemptData = @()
            for ($j=0; $j -lt $data.Count; $j++) {
                if ($j -eq $i) { continue; }
                else {
                    $attemptData += $data[$j]
                }
            }

            if (Check-Safety -data $attemptData) {
                $safetyCheckTwo = $true
                $safeReports++
            }
        }
    }
}

$safeReports