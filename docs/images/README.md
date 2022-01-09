# Images

## Naming rules

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
**(OPTIONAL)** company name

``` bash
${PRODUCT_NAME}
```
**(REQUIRED)** product name

``` bash
${PRODUCT_VERSION}
```
**(REQUIRED)** product version

``` bash
${PLATFORM_NAME}
```
**(REQUIRED)** target platform name (e.g. linux, windows)

``` bash
${IMAGE_BASE_NAME}
```
**(REQUIRED)** target image os name

``` bash
${IMAGE_BASE_VERSION}
```
**(REQUIRED)** target image os version

### Remarks
* symbol "```:```" can be replace to "```__```"

## Images list

* [base](base/)
  * [test](test/)
  * [fluentd](fluentd/)
  * [nginx](nginx/)

## Directory structure

``` shell
-- opt
   -- app
      -- bin
      -- conf
      -- data
      -- logs
      -- tmp
``` 

## Environment variables

* TZ

  time zone

* GID

  group ID

* UID

  user ID
