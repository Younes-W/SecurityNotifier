# Load all functions from public and private directories

# Public: for User accessible
$publicParams = @{
    Path = (Join-Path $PSScriptRoot "Public")
    Filter = '*ps1'
    ErrorAction = 'SilentlyContinue'
} 

$public = Get-ChildItem @publicParams

foreach ($file in $public) {
    . $file.FullName
}

# Private: only internaly, not exportable
$privateParams = @{
    Path = (Join-Path $PSScriptRoot "Private")
    Filer = '*.ps1'
    ErrorAction = SilentlyContinue
}

$private = Get-ChildItem @privateParams

foreach ($file in $private) {
    . $file.FullName
}

$exportFunctions = $public.BaseName
Export-ModuleMember -Function $exportFunctions -Alias *


