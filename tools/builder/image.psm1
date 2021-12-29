# vars
${BasePath} = ${PSScriptRoot}


# import modules
Import-Module ${BasePath}/config.psm1


# functions
function Invoke-CleanImage
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string] ${ImageName}
    )

    ${imageNameForUse} = Get-CorrectedImageName -ImageName ${ImageName}

    ${images} = docker image ls -q simpleunionspace/${imageNameForUse}*
    foreach (${image} in ${images}) {
        docker image rm -f ${image}
    }
}

function Invoke-BuildImage
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string] ${TemplatesDir},
        [Parameter(Mandatory=$true)]
        [array] ${Prototypes},
        [Parameter(Mandatory=$true)]
        [string] ${ImageName},
        [Parameter(Mandatory=$true)]
        [string] ${ImageTagSuffix}
    )

    foreach (${prototype} in ${Prototypes})
    {
        packer build `
               -force `
               -var-file="$(Convert-Path "${TemplatesDir}/${prototype}.pkrvars.hcl")" `
               -var "im_target_docker_image_tag_suffix=${ImageTagSuffix}" `
               "$(Convert-Path "${TemplatesDir}/${ImageName}/template.pkr.hcl")"
    }
}

function Invoke-PublishImage
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string] ${ImageName}
    )

    ${imageNameForUse} = Get-CorrectedImageName -ImageName ${ImageName}

    docker push --all-tags simpleunionspace/${imageNameForUse}
}


# export
Export-ModuleMember -function Invoke-CleanImage
Export-ModuleMember -function Invoke-BuildImage
Export-ModuleMember -function Invoke-PublishImage
