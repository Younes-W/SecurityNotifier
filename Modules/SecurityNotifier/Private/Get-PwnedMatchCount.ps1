function Get-PwnedMatchCount {
    param (
        [Parameter(Mandatory)][string]$Suffix,
        [Parameter(Mandatory)][string]$RangeResponse

    )

    foreach ($line in $RangeResponse -split "`n") {
        $parts = $line -split ':'
        if ($parts.Length -ge 2 -and $parts[0] -eq $Suffix) {
            return [int]$parts[1]
        }
    }
    return 0
}