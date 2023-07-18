function Write-nLog {
<#
.Synopsis
   Custom logging function with shortcuts for easier debugging

.DESCRIPTION
   Custom logging function, with a couple of bells and no whistles.
   Can log, can Warn, can throw

.INPUTS
    Log message in the string format

.EXAMPLE
   nLog 'HELLO THERE'
   Adding a message to the log

.EXAMPLE
   $nLog
   HELLO THERE
   Reading the log

.EXAMPLE
    $nLog = $null
    Clearing the log

.EXAMPLE
    nLog 'GENERAL NLOGGI' -Warning
    WARNING: GENERAL NLOGGI
    Writing to nLog and doing Write-Warning at the same time

.NOTES
   This was written because Write-Verbose is unusable if you have a ton of IWR calls.
   There is no explicit type on the message parameter, so you can add non-strings (ie object) there too, if such need arises
#>
    [CmdletBinding()]
    [Alias('nLog')]
    param (
        # Text to log
        [Parameter(ValueFromPipeline = $true)]
        $Message,

        # Output to warning
        [switch]$Warning,

        # Stop execution
        [switch]$Throw,

        # Output to the console
        [switch]$Console
    )

    # add the current invocation, if exists
    if (($MyInvocation.PSCommandPath).Length -gt 0) {
        $Message = '{0}: {1}' -f (Split-Path -Leaf $MyInvocation.PSCommandPath), $Message
    }

    # auto-init
    if ($null -eq $Global:nLog) {
        # global log variable
        $Global:nLog = [System.Collections.Generic.List[string]]::new()
        }

    $global:nLog.add($Message)

    if ($warning) {
        Write-Warning $Message
    }

    if ($Console) {
        Write-Host $Message
    }
    
    if ($throw) {
        throw $Message
    }
}