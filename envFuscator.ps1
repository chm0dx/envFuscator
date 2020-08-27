<#
.SYNOPSIS
Uses a host's environment variables to obfuscate commands.

.DESCRIPTION
Reconstructs command text by referencing env value character indexes. Can be run live and pull values directly from a host's env variables or alternatively by importing
a csv file export of env variables from a target system.

.PARAMETER cmd
Indicates the command being obfuscated.

.PARAMETER csvFile
Optionally specifies a csv file to read env variables from.

.EXAMPLE
.\envFuscator.ps1 -cmd Get-Service

.EXAMPLE
.\envFuscator.ps1 -cmd Involke-MimiDogz -csvFile C:\Data\env.csv

.LINK
https://github.com/chm0dx/envFuscator
#>

param (
    [parameter(Mandatory=$true)][string]$cmd,
    [string]$csvFile
)

$cmda = @()

if ($csvFile)
{
    $vars = import-csv $csvFile
}
else
{
    $vars = Get-ChildItem env:
}

foreach ($c in [char[]]$cmd)
{
    $done = $False
    $count = 0
    while ($done -eq $False)
    {
        $var = $vars | Get-Random
        $val = $var.Value
        $index = $val.IndexOf($c)
        if ($index -ne -1)
        {
            $done = $True
            $cmda += '${env:' + $var.Name + "}[" + $index + "]"
        }
        else
        {
            $count += 1
            if ($count -eq 25)
            {
                $done = $True
                $cmda += "'" + $c + "'"
            }
        }     
    }
}
    
$cmda -join " + "