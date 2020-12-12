Set-StrictMode -Version 3

${BasePath} = ${PSScriptRoot}

# base linux
powershell ${BasePath}/base-linux/clean.ps1

# docker prune
docker container prune -f
docker volume prune -f
docker image prune -f
