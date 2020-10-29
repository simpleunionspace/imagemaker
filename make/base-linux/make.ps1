Set-StrictMode -Version 3

${BasePath} = ${PSScriptRoot}

# ubuntu
## 20.04
docker build `
       --pull `
       --no-cache `
       --build-arg IMAGE_BASE_NAME=ubuntu `
       --build-arg IMAGE_BASE_VERSION=20.04 `
       --build-arg SYSTEM_PACKAGES_MANAGER=apt `
       --tag simpleunionspace/base-linux:ubuntu-20.04-$(Get-date -Format yyyyMMdd.HHmm) `
       --tag simpleunionspace/base-linux:ubuntu-20.04-latest `
       ${BasePath}/../../src/base-linux/

# centos
## 8
docker build `
       --pull `
       --no-cache `
       --build-arg IMAGE_BASE_NAME=centos `
       --build-arg IMAGE_BASE_VERSION=8 `
       --build-arg SYSTEM_PACKAGES_MANAGER=yum `
       --tag simpleunionspace/base-linux:centos-8-$(Get-date -Format yyyyMMdd.HHmm) `
       --tag simpleunionspace/base-linux:centos-8-latest `
       ${BasePath}/../../src/base-linux/
