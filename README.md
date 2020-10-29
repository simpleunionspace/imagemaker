# Base docker images

This repository contains docker images for infrastructure.

* on GitHub
  * [docker images](https://github.com/simpleunionspace/docker-images)

* on Docker Hub
  * [docker images](https://hub.docker.com/u/lifepainspace)

## Repository structure

* src  - source files
* make - build, publish and clean scenarios

## Images naming rules

* base-{PLATFORM}
  * example: base-linux
  * example: base-windows
* [COMPANY-]{NAME}-{PLATFORM}
  * example: sonarqube-linux
  * example: postgresql-linux

### Legend

* {PLATFORM} = target platform (e.g. linux, windows)

### REMARKS

* "-{PLATFORM}" suffix (for example, "-linux", "-windows") is optional and should be present if there are images for different platforms

## Images organizations

* base-linux
  * microsoft-mssql-linux
  * postgresql-linux
  * mysql-linux
  * mongodb-linux
  * rabbitmq-linux
  * xwiki-linux
  * rocketchat-linux
  * nexus-linux
  * jenkins-linux
  * sonarqube-linux
  * jetbrains-upsource-linux
  * jetbrains-youtrack-linux
  * jetbrains-teamcity-linux
