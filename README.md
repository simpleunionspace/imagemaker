# Base docker images

This repository contains docker images for infrastructure.

## Repository structure

* src  - source files
* make - build, publish and clean scenarios

## Images naming rules

* base-{PLATFORM}
  * example: base-linux
  * example: base-windows
* additional-{PLATFORM}
  * example: sonarqube-linux
  * example: postgresql-linux

### Legend

* {PLATFORM}   = target platform (e.g. linux, windows)

### REMARKS

* "-{PLATFORM}" suffix (for example, "-linux", "-windows") is optional and should be present if there are images for different platforms

## Images organizations

* base-linux
  * mongodb-linux
  * postgresql-linux
  * xwiki-linux
  * rocketchat-linux
  * jenkins-linux
  * nexus-linux
  * sonarqube-linux
