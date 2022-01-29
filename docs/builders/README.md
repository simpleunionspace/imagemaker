# Builders

## Overview

Builds an image for a specific platform.

See [Packer documentation](https://www.packer.io/docs/builders/) for more details.

## Structure

``` shell
-- ${builder_name}
   -- build
      -- provisioners
         -- begin.hcl
         -- end.hcl
      -- postprocessors
         -- begin.hcl
         -- end.hcl
```

## List

* [docker](docker/)
