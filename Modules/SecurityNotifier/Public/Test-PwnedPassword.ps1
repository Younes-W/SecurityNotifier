function Test-PwnedPassword {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [securestring]$Password
    )
    
    begin {
        
    }
    
    process {
        $plainPassword = [System.Net.NetworkCredential]::new("", $Password).Password
        $hash = Get-Sha1Hash -String $plainPassword
        $prefix = $hash.Substring(0,5)
        $suffix = $hash.Substring(5)

        $rangeResponse = Invoke-PwnedRange -Prefix $prefix

        $foundCount = Get-PwnedMatchCount -Suffix $suffix -RangeResponse $rangeResponse
        
        [PSCustomObject]@{
            Found = ($foundCount -gt 0)
            Count = $foundCount
            SHA1 = $hash
            Prefix = $prefix
            Suffix = $suffix
            CheckedAt = (Get-Date).ToString("o")
        }
    }
    
    end {
        
    }
}