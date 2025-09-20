function Get-PwnedMatchCount {
    param (
        [Parameter(Mandatory)][string]$Suffix,
        [Parameter(Mandatory)][string]$RangeResponse

    )

    foreach ($line in $RangeResponse -split "`n") {#
        $line = $line.Trim()
        if (-not $line) { continue }

        $parts = $line -split ':', 2
        if ($parts.Length -ge 2) {
            $remoteSuffix = $parts[0].Trim().ToUpperInvariant()
            $normSuffix = $Suffix.Trim().ToUpperInvariant()

            if ($remoteSuffix -eq $normSuffix) {
                return [int]$parts[1]
            }
            
        }
    }
    return 0
}