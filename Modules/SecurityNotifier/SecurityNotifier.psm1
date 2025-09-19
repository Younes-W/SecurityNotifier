# Private: only internal, not exportable
$privateParams = @{
    Path        = (Join-Path $PSScriptRoot "Private")
    Filter      = '*.ps1'
    ErrorAction = 'SilentlyContinue'
}

$private = Get-ChildItem @privateParams
foreach ($file in $private) {

    . $file.FullName
}

# Public: for User accessible
$publicParams = @{
    Path        = (Join-Path $PSScriptRoot "Public")
    Filter      = '*.ps1'
    ErrorAction = 'SilentlyContinue'
}

$public = Get-ChildItem @publicParams
foreach ($file in $public) {
    . $file.FullName
}

$exportFunctions = $public.BaseName
Export-ModuleMember -Function $exportFunctions
