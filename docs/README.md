# Documentations

## Images naming rules

* base:{PLATFORM_NAME}-{IMAGE_BASE_NAME}-{IMAGE_BASE_VERSION}
  * example: base:linux-ubuntu-20.04
  * example: base:windows-nanoserver-2004

* [COMPANY_NAME-]{PRODUCT_NAME}-{PRODUCT_VERSION}:{PLATFORM_NAME}-{IMAGE_BASE_NAME}-{IMAGE_BASE_VERSION}
  * example: microsoft-sqlserver-2019:windows-nanoserver-2004
  * example: postgresql-13:linux-ubuntu-20.04

### Legend

* [COMPANY_NAME-]      = company name
* {PRODUCT_NAME}       = product name
* {PRODUCT_VERSION}    = product version
* {PLATFORM_NAME}      = target platform name (e.g. linux, windows)
* {IMAGE_BASE_NAME}    = target image os name
* {IMAGE_BASE_VERSION} = target image os version

## Images organizations

* base
  * test
  * fluentd

## Image structure

* app
  * bin
  * conf
  * data
  * logs
  * tmp
