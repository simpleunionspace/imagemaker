# vars
${BasePath} = ${PSScriptRoot}


# import modules
Import-Module ${BasePath}/config.psm1


# functions
function Invoke-CleanImage
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
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
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] ${TemplatesDir},
        [Parameter(Mandatory=$true, Position=1)]
        [array] ${Prototypes},
        [Parameter(Mandatory=$true, Position=2)]
        [string] ${ImageName},
        [Parameter(Mandatory=$true, Position=3)]
        [string] ${ImageTagSuffix}
    )

    foreach (${prototype} in ${Prototypes})
    {
        packer build `
               -force `
               -var-file="$(Convert-Path "${TemplatesDir}/${prototype}.pkrvars.hcl")" `
               -var "image_tag_suffix=${ImageTagSuffix}" `
               "$(Convert-Path "${TemplatesDir}/${ImageName}/template.pkr.hcl")"
    }
}

function Invoke-PublishImage
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] ${ImageName}
    )

    ${imageNameForUse} = Get-CorrectedImageName -ImageName ${ImageName}

    docker push --all-tags simpleunionspace/${imageNameForUse}
}


# export
Export-ModuleMember -function Invoke-CleanImage
Export-ModuleMember -function Invoke-BuildImage
Export-ModuleMember -function Invoke-PublishImage
