Set-StrictMode -Version 3

${BasePath} = ${PSScriptRoot}

docker build `
       --pull `
       --no-cache `
       --tag simpleunionspace/base-linux:centos-$(Get-date -Format yyyyMMdd.HHmm) `
       --tag simpleunionspace/base-linux:centos-latest `
       --tag simpleunionspace/base-linux:latest `
       ${BasePath}/../../src/base-linux/
