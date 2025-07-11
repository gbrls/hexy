# The `hexy` Package
<div align="center">Version 0.1.0</div>

Typeset and draw precise **RASTER** graphics of binaries. No more:

- Pixelated images on your reports.
- Screenshots of `xxd` in your presentations.
- Building a custom script to display nice hex and binary formats.

I mean, you can still do those things, but now you can do it in a modern latex alternative.

## Getting Started


```typ
#import "/hexy.typ" as hexy
#import hexy: *

#hexdump("minimal.pdf", bytes-per-row: 16)
```

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./hello.svg">
  <img src="./hello.svg">
</picture>

