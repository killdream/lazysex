Lazysex [![Build Status](https://travis-ci.org/killdream/lazysex.png)](https://travis-ci.org/killdream/lazysex)
========================================================================

Fucking lazy. Fucking functional. Fucking sequences.

IOW, this gives you monadic streams and lots of cool combinators to work with
them.


### Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :3

[![browser support](http://ci.testling.com/killdream/lazysex.png)](http://ci.testling.com/killdream/lazysex)


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

You can run all tests using Mocha:

    $ npm test


### Licence

MIT/X11. ie.: do whatever you want.

[Calliope]: https://github.com/killdream/calliope
[es5-shim]: https://github.com/kriskowal/es5-shim
