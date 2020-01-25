# Base docker images

This repository contains docker images for infrastructure.

## Repository structure

* src  - source files
* make - build, publish and clean scenarios

## Images naming rules

* base-{PLATFORM}
  * example: base-linux
  * example: base-windows
* base-service-{PLATFORM}
  * example: base-service-linux
  * example: base-service-windows
* base-service-{TECHNOLOGY}-{PLATFORM}-{CONDITIONS}]
  * example: base-service-csharp-linux
  * example: base-service-nodejs-linux
  * example: base-service-nodejs-linux-preview
* additional-{PLATFORM}
  * example: sonarqube-linux
  * example: postgresql-linux

### Legend

* {PLATFORM}   = target platform (e.g. linux, windows)
* {TECHNOLOGY} = target technology (e.g. csharp, nodejs)
* {CONDITIONS} = additional condition (e.g. preview)

### REMARKS

* "-{PLATFORM}" suffix (for example, "-linux", "-windows") is optional and should be present if there are images for different platforms

## Images organizations

* base-linux
  * base-service-linux
    * base-service-csharp-linux
    * base-service-nodejs-linux
  * mongodb-linux
  * postgresql-linux
  * xwiki-linux
  * rocketchat-linux
  * jenkins-linux
  * nexus-linux
  * sonarqube-linux
