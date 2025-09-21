function Write-Log {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [string]$LogFile = (Join-Path $PSScriptRoot "..\..\..\Logs\SecurityNotifier.log"),

        [ValidateSet("INFO","WARN","ERROR")]
        [string]$level = "INFO"
    )

    $timestamp = (Get-Date).ToString("o")
    $line = "[$timestamp] [$level] $message"

    $logDir = Split-Path $LogFile -Parent
    if (-not (Test-Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
    }

    Add-Content -Path $LogFile -Value $line
}