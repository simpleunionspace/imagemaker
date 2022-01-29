# vars
${BasePath}                = ${PSScriptRoot}
${DefaultSrcPath}          = ${BasePath} + "./../../src"
${SrcBuildersPathSuffix}   = "/builders"
${SrcPrototypesPathSuffix} = "/prototypes"
${SrcImagesPathSuffix}     = "/images"


# functions
function Get-SrcPath
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    ${SrcPathToUse} = ${DefaultSrcPath}

    if (${SrcPath} -eq $null)
    {
        ${SrcPathToUse} = ${SrcPath}
    }

    return ${SrcPathToUse}
}
function Get-SrcBuildersPath
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return (Get-SrcPath -SrcPath ${SrcPath}) + ${SrcBuildersPathSuffix}
}
function Get-SrcPrototypesPath
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return (Get-SrcPath -SrcPath ${SrcPath}) + ${SrcPrototypesPathSuffix}
}
function Get-SrcImagesPath
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return (Get-SrcPath -SrcPath ${SrcPath}) + ${SrcImagesPathSuffix}
}

function Get-BuildersList
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return Get-ChildItem -Path (Get-SrcBuildersPath -SrcPath ${SrcPath}) -Directory
}

function Get-PrototypesList
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return Get-ChildItem -Path (Get-SrcPrototypesPath -SrcPath ${SrcPath}) -Directory
}
function Get-LinuxPrototypesList
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return Get-PrototypesList -SrcPath ${SrcPath} | Select-String -SimpleMatch linux
}
function Get-WindowsPrototypesList
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return Get-PrototypesList -SrcPath ${SrcPath} | Select-String -SimpleMatch windows
}

function Get-ImagesList
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return Get-ChildItem -Path (Get-SrcImagesPath -SrcPath ${SrcPath}) -Directory
}
function Get-LinuxImagesList
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$false)]
        [string] ${SrcPath}
    )

    return Get-ImagesList -SrcPath ${SrcPath} | Select-String -SimpleMatch linux
}
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
Export-ModuleMember -function Get-SrcPath
Export-ModuleMember -function Get-SrcBuildersPath
Export-ModuleMember -function Get-SrcPrototypesPath
Export-ModuleMember -function Get-SrcImagesPath

Export-ModuleMember -function Get-BuildersList

Export-ModuleMember -function Get-PrototypesList
Export-ModuleMember -function Get-LinuxPrototypesList
Export-ModuleMember -function Get-WindowsPrototypesList

Export-ModuleMember -function Get-ImagesList
Export-ModuleMember -function Get-LinuxImagesList
Export-ModuleMember -function Get-WindowsImagesList
