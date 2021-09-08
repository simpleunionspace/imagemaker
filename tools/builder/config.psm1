# vars
${LinuxPrototypesList}   = @("linux-ubuntu-1804",
                             "linux-ubuntu-2004",
                             "linux-centos-7",
                             "linux-centos-8")
${WindowsPrototypesList} = @("windows-nanoserver-2004",
                             "windows-nanoserver-20H2")

${LinuxImagesList}       = @("base-linux",
                             "test",
                             "fluentd")
${WindowsImagesList}     = @("base-windows",
                             "test")

# vars override
${LinuxPrototypesList}   = @("linux-ubuntu-1804")
${LinuxImagesList}       = @("base-linux",
                             "test")


# functions
function Get-LinuxPrototypesList
{
    return ${LinuxPrototypesList}
}
function Get-WindowsPrototypesList
{
    return ${WindowsPrototypesList}
}

function Get-LinuxImagesList
{
    return ${LinuxImagesList}
}
function Get-WindowsImagesList
{
    return ${WindowsImagesList}
}

function Get-ImagesListForPublish
{
    ${result}=@()

    foreach (${item} in ${LinuxImagesList}) {
        ${result}.Add(${item})
    }

    foreach (${item} in ${WindowsImagesList}) {
        if (${result}.Contains(${item}) -eq $true) {
            continue
        }

        ${result}.Add(${item})
    }

    return ${result}
}

function Get-CorrectedImageName {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string] ${ImageName}
    )
    
    ${imageNameForUse} = ${ImageName}

    if (${ImageName} -like "base-*") {
        ${imageNameForUse} = "base"
    }

    return ${imageNameForUse}
}


# export
Export-ModuleMember -function Get-LinuxPrototypesList
Export-ModuleMember -function Get-WindowsPrototypesList
Export-ModuleMember -function Get-LinuxImagesList
Export-ModuleMember -function Get-WindowsImagesList
Export-ModuleMember -function Get-ImagesListForPublish
Export-ModuleMember -function Get-CorrectedImageName
