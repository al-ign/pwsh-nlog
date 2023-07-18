# Write-nLog

## SYNOPSIS

Custom logging function with some shortcuts for easier debugging

## SYNTAX

```powershell
Write-nLog [-Message <String>] [-Warning] [-Throw] [-Console] [-NoInvocationInfo] [<CommonParameters>]



Write-nLog [-Object <Object>] [-Warning] [-Throw] [-Console] [-NoInvocationInfo] [<CommonParameters>]
```
## DESCRIPTION

Custom logging function, with a couple of bells and no whistles.
Logs text or objects, can also tee to the warning stream and/or console

## PARAMETERS

### -Message &lt;String&gt;
Text to log

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       true (ByValue)
Accept wildcard characters?  false
```
 
### -Object &lt;Object&gt;
Object to add to the log

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Warning &lt;SwitchParameter&gt;
Output to the warning stream

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Throw &lt;SwitchParameter&gt;
Stop execution

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Console &lt;SwitchParameter&gt;
Output to the console

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -NoInvocationInfo &lt;SwitchParameter&gt;
Don't add invocation info

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

Log message in the string format

## OUTPUTS



## NOTES

This was written because Write-Verbose is unusable if you have a ton of IWR calls.
There is no explicit type on the array, so you can add non-strings (ie objects) with -Object parameter.
Sadly you need to explicitly call this, otherwise it messes up storing and displaying a regular strings.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\>nLog 'HELLO THERE'

Adding a message to the log
```

 
### EXAMPLE 2

```powershell
PS C:\>$nLog

HELLO THERE

Reading the log
```

 
### EXAMPLE 3

```powershell
PS C:\>$nLog = $null

Clearing the log
```

 
### EXAMPLE 4

```powershell
PS C:\>nLog 'GENERAL NLOGGI' -Warning

WARNING: GENERAL NLOGGI

Writing to nLog and doing Write-Warning at the same time
```

 
### EXAMPLE 5

```powershell
PS C:\>nlog -Console It`'s coarse and rough and irritating`, and it gets everywhere

It's coarse and rough and irritating, and it gets everywhere

You don't actually need to mark the message explicitly with the quotes, but beware of the escaping
```


