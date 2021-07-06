# Documentations

## Images naming rules

* base:{PLATFORM_NAME}-{IMAGE_BASE_NAME}-{IMAGE_BASE_VERSION}
  * example: base:linux-ubuntu-20.04
  * example: base:windows-nanoserver-2004

* [COMPANY_NAME-]{PRODUCT_NAME}-{PRODUCT_VERSION}:{PLATFORM_NAME}-{IMAGE_BASE_NAME}-{IMAGE_BASE_VERSION}
  * example: microsoft-sqlserver-2019:windows-nanoserver-2004
  * example: postgresql-13:linux-ubuntu-20.04

### Legend

* [COMPANY_NAME-]

  **(optional)** company name

* {PRODUCT_NAME}

  **(required)** product name 

* {PRODUCT_VERSION}

  **(required)** product version

* {PLATFORM_NAME}

  **(required)** target platform name (e.g. linux, windows)

* {IMAGE_BASE_NAME}

  **(required)** target image os name

* {IMAGE_BASE_VERSION}

  **(required)** target image os version

## Images organizations

* base
  * test
  * fluentd

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
