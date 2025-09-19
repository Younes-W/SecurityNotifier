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