# Base docker images

This repository contains docker images for infrastructure.

* on GitHub
  * [docker images](https://github.com/simpleunionspace/docker-images)

* on Docker Hub
  * [docker images](https://hub.docker.com/u/lifepainspace)

## Repository structure

* src  - source files
* make - clean and build scenarios

## Images naming rules

* base:{PLATFORM}-{IMAGE_BASE_NAME}-{IMAGE_BASE_VERSION}
  * example: base:linux-ubuntu-20.04
  * example: base:windows-server-2019
* [COMPANY-]{PRODUCT}:{PLATFORM}-{IMAGE_BASE_NAME}-{IMAGE_BASE_VERSION}
  * example: microsoft-sqlserver:windows-server-2019
  * example: postgresql:linux-ubuntu-20.04

### Legend

* {PLATFORM}           = target platform (e.g. linux, windows)
* {IMAGE_BASE_NAME}    = target image os name
* {IMAGE_BASE_VERSION} = target image os version

### REMARKS

* "-{PLATFORM}" suffix (for example, ":linux", ":windows") is optional and should be present if there are images for different platforms

## Images organizations

* base:windows
  * microsoft-sqlserver:windows
* base:linux
  * microsoft-sqlserver:linux
  * postgresql:linux
  * mysql:linux
  * mongodb:linux
  * rabbitmq:linux
  * xwiki:linux
  * rocketchat:linux
  * nexus:linux
  * jenkins:linux
  * sonarqube:linux
  * jetbrains-upsource:linux
  * jetbrains-youtrack:linux
  * jetbrains-teamcity:linux
