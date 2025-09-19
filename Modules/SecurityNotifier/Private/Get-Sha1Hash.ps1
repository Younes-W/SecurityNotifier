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