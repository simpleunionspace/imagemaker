Set-StrictMode -Version 3

${BasePath} = ${PSScriptRoot}

${DockerImages} = docker images -q lifepainspace/base-linux
foreach (${DockerImage} in ${DockerImages}) {
    docker rmi -f ${DockerImage}
}
