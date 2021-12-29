Set-StrictMode -Version 3


# vars
${BasePath}       = ${PSScriptRoot}
${ImageTagSuffix} = $(Get-Date -Format "yyyyMMdd.HHmm")
${CleanDocker}    = $true
${BuildLinux}     = $false
${BuildWindows}   = $false
${CLIArguments}   = {}


# import modules
Import-Module ${BasePath}/logging.psm1
Import-Module ${BasePath}/config.psm1
Import-Module ${BasePath}/image.psm1


# functions
function CleanLinux {
    ${images} = Get-LinuxImagesList

    Write-LogMessage -Message "clean $(${images}.Count) images"

    for ($i=${images}.Count; $i -gt 0; $i--) {
        Write-LogMessage -Message "clean image - $(${images}[$i-1])"

        Invoke-CleanImage -ImageName ${images}[$i-1]
    }
}
function CleanWindows {
    ${images} = Get-WindowsImagesList

    Write-LogMessage -Message "clean $(${images}.Count) images"

    for ($i=${images}.Count; $i -gt 0; $i--) {
        Write-LogMessage -Message "clean image - $(${images}[$i-1])"

        Invoke-CleanImage -ImageName ${images}[$i-1]
    }
}

function BuildLinux {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string] ${ImageTagSuffix}
    )

    ${images} = Get-LinuxImagesList

    Write-LogMessage -Message "make $(${images}.Count) images"

    foreach (${image} in ${images}) {
        Write-LogMessage -Message "make image - ${image}"

        Invoke-BuildImage -TemplatesDir "$(Convert-Path "${BasePath}/../../src/")" `
                          -Prototypes $(Get-LinuxPrototypesList) `
                          -ImageName ${image} `
                          -ImageTagSuffix ${ImageTagSuffix}
    }
}
function BuildWindows {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string] ${ImageTagSuffix}
    )

    ${images} = Get-WindowsImagesList

    Write-LogMessage -Message "make $(${images}.Count) images"

    foreach (${image} in ${images}) {
        Write-LogMessage -Message "make image - ${image}"

        Invoke-BuildImage -TemplatesDir "$(Convert-Path "${BasePath}/../../src/")" `
                          -Prototypes $(Get-WindowsPrototypesList) `
                          -ImageName ${image} `
                          -ImageTagSuffix ${ImageTagSuffix}
    }
}

function Publish {
    ${images} = Get-ImagesListForPublish

    Write-LogMessage -Message "publish $(${images}.Count) images"

    foreach (${image} in ${images}) {
        Write-LogMessage -Message "publish image - ${image}"

        Invoke-PublishImage -ImageName ${image}
    }
}


# work
## analyze cli arguments
for ($i = 0; $i -lt $args.Count; $i++) {
}
## clean images
if (${BuildLinux}) {
    Write-LogMessage -Message "Clean linux images"
    CleanLinux
}
if (${BuildWindows}) {
    Write-LogMessage -Message "Clean windows images"
    CleanWindows
}
## clean docker
if (${CleanDocker}) {
    Write-LogMessage -Message "Clean docker"
    docker container prune -f
    docker volume prune -f
    docker image prune -f
}
## build images
if (${BuildLinux}) {
    Write-LogMessage -Message "Build linux images"
    BuildLinux -ImageTagSuffix ${imageTagSuffix}
}
if (${BuildWindows}) {
    Write-LogMessage -Message "Build windows images"
    BuildWindows -ImageTagSuffix ${imageTagSuffix}
}
## publish images
# Publish
