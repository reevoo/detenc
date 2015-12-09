# detenc

[![Build Status](https://travis-ci.org/reevoo/detenc.svg?branch=master)](https://travis-ci.org/reevoo/detenc)

A lightweight, low-memory character encoding detector.

Paul Battley <pbattley@gmail.com> http://www.reevoo.com/

detenc is a fast character encoding detector for Western European text.  It can
determine whether a file is encoded in US-ASCII, UTF-8, ISO-8859-15,
WINDOWS-1252, or something else. It can distinguish ISO-8859-15 and
WINDOWS-1252 where there is enough information: this means that Euro signs are
handled correctly.

The program was written to help normalise the encoding of very large data feeds
(of the order of several gigabytes) at Reevoo. It uses very little memory and
can determine the encoding of a two-gigabyte file in under a minute.

### Build

The program is written in C and uses standard libraries. The test suite is
written in Ruby and depends on minitest.

```
make         # builds binary
make check   # runs test suite against binary
make install # installs binary to /usr/local/bin
```

It is also possible to build the binary manually: use something like:

`cc -o bin/detenc src/*.c`

### Use

`detenc FILENAME (FILENAME ...)`

This will output the filename and encoding, one per line. To print just the
encoding, use the -q switch.
