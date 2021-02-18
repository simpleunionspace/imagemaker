Set-StrictMode -Version 3


# vars
${BasePath} = ${PSScriptRoot}


# import modules
Import-Module ${BasePath}/config.psm1
Import-Module ${BasePath}/image.psm1


# functions
function Clean {
    CleanLinux
    CleanWindows

    # docker prune
    docker container prune -f
    docker volume prune -f
    docker image prune -f
}

function CleanLinux {
    ${images} = Get-LinuxImagesList

    Write-Output "***** clean $(${images}.Count) images"

    for ($i=${images}.Count; $i -gt 0; $i--) {
        Write-Output "***** clean image - $(${images}[$i-1])"
        Invoke-CleanImage -ImageName ${images}[$i-1]
    }
}
function CleanWindows {
    ${images} = Get-WindowsImagesList

    Write-Output "***** clean $(${images}.Count) images"

    for ($i=${images}.Count; $i -gt 0; $i--) {
        Write-Output "***** clean image - $(${images}[$i-1])"
        Invoke-CleanImage -ImageName ${images}[$i-1]
    }
}

function Build {
    ${imageTagSuffix} = $(Get-Date -Format yyyyMMddHHmm)

    BuildLinux -ImageTagSuffix ${imageTagSuffix}
    BuildWindows -ImageTagSuffix ${imageTagSuffix}
}

function BuildLinux {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] ${ImageTagSuffix}
    )

    ${images} = Get-LinuxImagesList

    Write-Output "***** make $(${images}.Count) images"

    foreach (${image} in ${images}) {
        Write-Output "***** make image - ${image}"
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

    Write-Output "***** make $(${images}.Count) images"

    foreach (${image} in ${images}) {
        Write-Output "***** make image - ${image}"
        Invoke-BuildImage -TemplatesDir "$(Convert-Path "${BasePath}/../../src/")" `
                          -Prototypes $(Get-WindowsPrototypesList) `
                          -ImageName ${image} `
                          -ImageTagSuffix ${ImageTagSuffix}
    }
}

function Publish {
    ${images} = Get-ImagesListForPublish

    Write-Output "***** publish $(${images}.Count) images"

    foreach (${image} in ${images}) {
        Write-Output "***** publish image - ${image}"
        Invoke-PublishImage -ImageName ${image}
    }
}


# work
Clean
Build
# Publish
