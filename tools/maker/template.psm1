# vars
${BasePath} = ${PSScriptRoot}


# import modules
Import-Module ${BasePath}/config.psm1


# functions
function Get-WindowsImagesList
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return Get-ImagesList -SrcPath ${SrcPath} | Select-String -SimpleMatch windows
}


# export
Export-ModuleMember -function Get-BuildersList
