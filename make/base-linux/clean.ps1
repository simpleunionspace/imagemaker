Set-StrictMode -Version 3

${BasePath} = ${PSScriptRoot}

${DockerImages} = docker images -q simpleunionspace/base:linux*
foreach (${DockerImage} in ${DockerImages}) {
    docker rmi -f ${DockerImage}
}
