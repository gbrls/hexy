#import "/hexy.typ" as hexy
#import hexy: *

#set page(width: auto, height: auto)
#set text(fill: color.rgb(128, 128, 255))

#hexdump("/tests/test1/hello.pdf", bytes-per-row: 32)
// Hello World
