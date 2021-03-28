Set-StrictMode -Version 3


# vars
${BasePath} = ${PSScriptRoot}


# import modules
Import-Module ${BasePath}/config.psm1
Import-Module ${BasePath}/image.psm1


# functions
function CleanLinux {
    ${images} = Get-LinuxImagesList

    Write-Output "**************************************************"
    Write-Output "***** clean $(${images}.Count) images"
    Write-Output "**************************************************"

    for ($i=${images}.Count; $i -gt 0; $i--) {
        Write-Output "**************************************************"
        Write-Output "***** clean image - $(${images}[$i-1])"
        Write-Output "**************************************************"

        Invoke-CleanImage -ImageName ${images}[$i-1]
    }
}
function CleanWindows {
    ${images} = Get-WindowsImagesList

    Write-Output "**************************************************"
    Write-Output "***** clean $(${images}.Count) images"
    Write-Output "**************************************************"

    for ($i=${images}.Count; $i -gt 0; $i--) {
        Write-Output "**************************************************"
        Write-Output "***** clean image - $(${images}[$i-1])"
        Write-Output "**************************************************"

        Invoke-CleanImage -ImageName ${images}[$i-1]
    }
}

function BuildLinux {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] ${ImageTagSuffix}
    )

    ${images} = Get-LinuxImagesList

    Write-Output "**************************************************"
    Write-Output "***** make $(${images}.Count) images"
    Write-Output "**************************************************"

    foreach (${image} in ${images}) {
        Write-Output "**************************************************"
        Write-Output "***** make image - ${image}"
        Write-Output "**************************************************"

        Invoke-BuildImage -TemplatesDir "$(Convert-Path "${BasePath}/../../src/")" `
                          -Prototypes $(Get-LinuxPrototypesList) `
                          -ImageName ${image} `
                          -ImageTagSuffix ${ImageTagSuffix}
    }
}
function BuildWindows {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] ${ImageTagSuffix}
    )

    ${images} = Get-WindowsImagesList

    Write-Output "**************************************************"
    Write-Output "***** make $(${images}.Count) images"
    Write-Output "**************************************************"

    foreach (${image} in ${images}) {
        Write-Output "**************************************************"
        Write-Output "***** make image - ${image}"
        Write-Output "**************************************************"

        Invoke-BuildImage -TemplatesDir "$(Convert-Path "${BasePath}/../../src/")" `
                          -Prototypes $(Get-WindowsPrototypesList) `
                          -ImageName ${image} `
                          -ImageTagSuffix ${ImageTagSuffix}
    }
}

function Publish {
    ${images} = Get-ImagesListForPublish

    Write-Output "**************************************************"
    Write-Output "***** publish $(${images}.Count) images"
    Write-Output "**************************************************"

    foreach (${image} in ${images}) {
        Write-Output "**************************************************"
        Write-Output "***** publish image - ${image}"
        Write-Output "**************************************************"

        Invoke-PublishImage -ImageName ${image}
    }
}


# work
## generate image tag suffix
${imageTagSuffix} = $(Get-Date -Format "yyyyMMdd.HHmm")
## clean images
CleanLinux
CleanWindows
## clean docker
docker container prune -f
docker volume prune -f
docker image prune -f
## build images
BuildLinux -ImageTagSuffix ${imageTagSuffix}
# BuildWindows -ImageTagSuffix ${imageTagSuffix}
## publish images
# Publish
