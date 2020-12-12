Set-StrictMode -Version 3

${BasePath} = ${PSScriptRoot}

${ImageTagSuffix}=$(Get-Date -Format yyyyMMdd.HHmm)

${VarFiles} = @("$(Convert-Path $(Join-Path ${BasePath} '/../../src/linux-ubuntu-1804.json'))",
                "$(Convert-Path $(Join-Path ${BasePath} '/../../src/linux-ubuntu-2004.json'))",
                "$(Convert-Path $(Join-Path ${BasePath} '/../../src/linux-centos-7.json'))",
                "$(Convert-Path $(Join-Path ${BasePath} '/../../src/linux-centos-8.json'))")


foreach (${VarFile} in ${VarFiles})
{
    packer build `
           -force `
           -var-file="${VarFile}" `
           -var "image_tag_suffix=${ImageTagSuffix}" `
           ${BasePath}/../../src/base-linux/template.json
}
