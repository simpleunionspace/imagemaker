# Documentations

## Overview

Image Maker is designed to build images for different platforms.

Based on:
* [HashiCorp Packer](https://www.packer.io/)
* [powershell-templating](https://github.com/simpleunionspace/powershell-templating/)

## Structure

* [builders](builders/)
* [prototypes](prototypes/)
* [images](images/)

## Build process

``` shell
-- prepare
   -- processing template
-- build
   -- provisioners
      -- "begin" from builder
      -- from image
      -- "end" from builder
   -- postprocessors
      -- "begin" from builder
      -- from image
      -- "end" from builder
-- publish
```
