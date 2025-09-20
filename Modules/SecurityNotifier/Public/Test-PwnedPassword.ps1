<#
.SYNOPSIS
    Tests if a password has been exposed in known data breaches.

.DESCRIPTION
    Uses the HaveIBeenPwned PwnedPasswords API (k-Anonymity model).
    Only the first 5 characters of the SHA1 hash are sent to the API.
    The suffix is compared locally, so the full password is never exposed.

.PARAMETER Password
    The password to check (provided as SecureString).

.EXAMPLE
    PS> Test-PwnedPassword -Password (Read-Host "Enter password" -AsSecureString)

    Returns a custom object showing whether the password was found,
    how many times it appeared, and the hash details.
#>
function Test-PwnedPassword {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [securestring]$Password
    )
    
    begin {
        
    }
    
    process {
        try {
            $plainPassword = [System.Net.NetworkCredential]::new("", $Password).Password
            $hash = Get-Sha1Hash -String $plainPassword
            
            if ($hash.Length -ne 40) {
                throw "Unexpected SHA1 hash length ($($hash.Length))."
            }
            
            $prefix = $hash.Substring(0,5).ToUpperInvariant()
            $suffix = $hash.Substring(5).ToUpperInvariant()

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
        catch {
            throw "Test-PwnedPassword failed: $($_.Exception.Message)"
        }
    }
    
    end {
        
    }
}