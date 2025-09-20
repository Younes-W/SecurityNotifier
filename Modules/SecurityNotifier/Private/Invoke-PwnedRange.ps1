function Invoke-PwnedRange {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidatePattern('^[A-F0-9]{5}$')]
        [string]$Prefix
    )
    $prefix = $Prefix.Trim().ToUpperInvariant()
    $url = "https://api.pwnedpasswords.com/range/$Prefix"

    try {
        $response = Invoke-RestMethod -Uri $url -Method Get `
        -Headers @{ 'User-Agent' = 'SecurityNotifier/1.0'} `
        -ErrorAction Stop

        return ($response | Out-String)

    }
    catch {
       Throw "Range API request failed: $($_.Exception.Message)"
    }
}