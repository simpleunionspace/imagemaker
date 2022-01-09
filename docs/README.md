# Documentations

## Images naming rules

``` bash
base:${PLATFORM_NAME}-${IMAGE_BASE_NAME}-${IMAGE_BASE_VERSION}
```
* example: base:linux-ubuntu-20.04
* example: base:windows-nanoserver-2004

``` bash
${COMPANY_NAME}-base:${PLATFORM_NAME}-${IMAGE_BASE_NAME}-${IMAGE_BASE_VERSION}
```
* example: microsoft-base:windows-nanoserver-2004
* example: jetbrains-base:linux-ubuntu-20.04

``` bash
[COMPANY_NAME-]${PRODUCT_NAME}-base:${PLATFORM_NAME}-${IMAGE_BASE_NAME}-${IMAGE_BASE_VERSION}
```
* example: microsoft-sqlserver-base:windows-nanoserver-2004
* example: jetbrains-teamcity-base:linux-ubuntu-20.04

``` bash
[COMPANY_NAME-]${PRODUCT_NAME}:${PRODUCT_VERSION}-${PLATFORM_NAME}-${IMAGE_BASE_NAME}-${IMAGE_BASE_VERSION}
```
* example: microsoft-sqlserver-2019:windows-nanoserver-2004
* example: jetbrains-teamcity-server-2021:linux-ubuntu-20.04
* example: jetbrains-teamcity-agent-2021:linux-ubuntu-20.04

### Legend

``` bash
[COMPANY_NAME-]
```
**(optional)** company name

``` bash
${PRODUCT_NAME}
```
**(required)** product name

``` bash
${PRODUCT_VERSION}
```
**(required)** product version

``` bash
${PLATFORM_NAME}
```
**(required)** target platform name (e.g. linux, windows)

``` bash
${IMAGE_BASE_NAME}
```
**(required)** target image os name

``` bash
${IMAGE_BASE_VERSION}
```
**(required)** target image os version

## [Prototypes](prototypes/)

* linux
  * centos
    * 7
    * 8
  * ubuntu
    * 18.04
    * 20.04
* windows
  * nanoserver
    * 2004
    * 20H2

## Images organizations

* [base](images/base/)
  * [test](images/test/)
  * [fluentd](images/fluentd/)
  * [nginx](images/nginx/)

## Image structure

```shell
-- opt
   -- app
      -- bin
      -- conf
      -- data
      -- logs
      -- tmp
``` 

## Image environment

* TZ

  time zone

* GID

  group ID

* UID

  user ID
