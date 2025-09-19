function Get-Sha1Hash {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$String
    )

    $sha1 = [System.Security.Cryptography.SHA1]::Create()
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($String)
    $hashBytes = $sha1.ComputeHash($bytes)
    $hash = ($hashBytes | ForEach-Object {$_.ToString("X2")}) -join ""
    return $hash
}

function Invoke-PwnedRange {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Prefix
    )

    $url = "https://api.pwnedpasswords.com/range/$Prefix"

    try {
        return Invoke-RestMethod -Uri $url -Method Get `
        -Headers @{ 'User-Agent' = 'SecurityNotifier/1.0'} `
        -ErrorAction Stop
    }
    catch {
       Throw "Range API request failed: $($_.Exception.Message)"
    }
}

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