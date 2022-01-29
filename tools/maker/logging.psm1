# vars
${BasePath} = ${PSScriptRoot}


# functions
function Write-LogMessage
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string] ${Message}
    )

    Write-Output "**************************************************"
    Write-Output "***** $(${Message})"
    Write-Output "**************************************************"
}


# export
Export-ModuleMember -function Write-LogMessage
