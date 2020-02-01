Set-StrictMode -Version 3

${BasePath} = ${PSScriptRoot}

# base linux
powershell ${BasePath}/base-linux/clean.ps1

docker container prune -f
docker image prune -a -f
