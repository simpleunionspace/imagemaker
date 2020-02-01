Set-StrictMode -Version 3

${BasePath} = ${PSScriptRoot}

docker build `
       --pull `
       --no-cache `
       --tag lifepainspace/base-linux:$(Get-date -Format yyyyMMdd.HHmm) `
       --tag lifepainspace/base-linux:centos-latest `
       --tag lifepainspace/base-linux:latest `
       ${BasePath}/../../src/base-linux/
