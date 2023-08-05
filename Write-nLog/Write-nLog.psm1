function Write-nLog {
<#
.Synopsis
   Custom logging function with some shortcuts for easier debugging

.DESCRIPTION
   Custom logging function, with a couple of bells and no whistles.
   Logs text or objects, can also tee to the warning stream and/or console

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
.EXAMPLE
    nlog -Console It`'s coarse and rough and irritating`, and it gets everywhere 
    It's coarse and rough and irritating, and it gets everywhere

    You don't actually need to mark the message explicitly with the quotes, but beware of the escaping
.NOTES
   This was written because Write-Verbose is unusable if you have a ton of IWR calls.
   There is no explicit type on the array, so you can add non-strings (ie objects) with -Object parameter.
   Sadly you need to explicitly call this, otherwise it messes up storing and displaying a regular strings.
.LINK
    https://github.com/al-ign/pwsh-nlog
#>
    [CmdletBinding(DefaultParameterSetName='Message')]
    [Alias('nLog')]
    param (
        # Text to log
        [Parameter(
            ParameterSetName='Message',
            ValueFromPipeline = $true,
            ValueFromRemainingArguments=$true
            )]
        [string]$Message,

        # Object to add to the log
        [Parameter(
            ParameterSetName='Object'
            )]
        $Object,

        # Output to the warning stream
        [switch]$Warning,

        # Stop execution
        [switch]$Throw,

        # Output to the console
        [switch]$Console,

        # Don't add invocation info
        [switch]$NoInvocationInfo
    )

    # auto-init
    if ($null -eq $Global:nLog) {
        
        # global log variable
        $Global:nLog = [System.Collections.Generic.List[PSCustomObject]]::new()
        
        }

    if ($PsCmdlet.ParameterSetName -eq 'Message') {

        if ($null -eq $Message) {
            $Message = '{0} nLog was called with an empty message' -f (Get-Date -Format s)
            }

        # add the current script name, if available
        if ( 
            (-not $NoInvocationInfo) -and 
            ( ($MyInvocation.PSCommandPath).Length -gt 0 ) 
           ) {
            $Message = '{0}: {1}' -f (Split-Path -Leaf $MyInvocation.PSCommandPath), $Message
            }

        } #end if Message

    elseif ($PsCmdlet.ParameterSetName -eq 'Object') {

        $Message = $Object
        }
    
    $Global:nLog.add($Message)

    if ($Warning) {
        Write-Warning $Message
        }

    if ($Console) {
        Write-Host $Message
        }
    
    if ($Throw) {
        throw $Message
        }

    } # end function Write-nLog
