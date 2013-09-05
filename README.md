Lazysex 
=======

[![experimental](http://hughsk.github.io/stability-badges/dist/experimental.svg)](http://github.com/hughsk/stability-badges)
[![Build Status](https://secure.travis-ci.org/killdream/lazysex.png?branch=master)](https://travis-ci.org/killdream/lazysex)
[![Dependencies Status](https://david-dm.org/killdream/lazysex.png)](https://david-dm.org/killdream/lazysex)

Monadic streams with lots of cool combinators to manipulate and abstract over
them!

IOW, fucking lazy. Fucking functional. Fucking sequences.


### Example

```js
var s = require('lazysex')
var naturals = s.iterate(function(n) { return n + 1 }, 0)
var squared  = naturals.map(function(n) { return n * n })

squared.take(10) // => [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```


### Installing

Just grab it from NPM:

    $ npm install lazysex


### Documentation

A quick reference of the API can be built using [Calliope][]:

    $ npm install -g calliope
    $ calliope build


### Tests

On Node:

    $ npm test


### Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :3

[![browser support](http://ci.testling.com/killdream/lazysex.png)](http://ci.testling.com/killdream/lazysex)


### Licence

MIT/X11. ie.: do whatever you want.

[Calliope]: https://github.com/killdream/calliope
[es5-shim]: https://github.com/kriskowal/es5-shim
