(function(){
  var Nothing, fold, foldl, head, tail, last, nth, butLast, indexOf, length, isEmpty, map, reverse, interpose, interleave, concat, mapConcat, any, all, sum, product, maximum, minimum, iterate, repeat, replicate, cycle, take, drop, takeWhile, dropWhile, splitAt, span, break1, contains, find, filter, partition, zip, zipWith, unzip, slice$ = [].slice;
  Nothing = require('./stream').Nothing;
  fold = curry$(function(f, initial, as){
    return as.reduceRight(f, initial);
  });
  foldl = curry$(function(f, initial, as){
    return as.reduce(f, initial);
  });
  head = function(as){
    return as.head;
  };
  tail = function(as){
    return as.tail();
  };
  last = foldl(function(a){
    return a;
  }, void 8);
  nth = curry$(function(k, as){
    while (--k && (as = as.tail()) !== Nothing) {}
    return as.head;
  });
  butLast = function(as){
    throw Error('unimplemented');
  };
  indexOf = curry$(function(a, as){
    throw Error('unimplemented');
  });
  length = foldl((function(it){
    return it + 1;
  }), 0);
  isEmpty = (function(it){
    return it === Nothing;
  });
  map = curry$(function(f, as){
    return as.map(f);
  });
  reverse = curry$(function(f, as){
    throw Error('unimplemented');
  });
  interpose = curry$(function(separator, as){
    throw Error('unimplemented');
  });
  interleave = function(){
    var as;
    as = slice$.call(arguments);
    throw Error('unimplemented');
  };
  concat = function(){
    var as;
    as = slice$.call(arguments);
    throw Error('unimplemented');
  };
  mapConcat = curry$(function(f, as){
    throw Error('unimplemented');
  });
  any = curry$(function(f, as){
    throw Error('unimplemented');
  });
  all = curry$(function(f, as){
    throw Error('unimplemented');
  });
  sum = foldl(curry$(function(x$, y$){
    return x$ + y$;
  }), 0);
  product = foldl(curry$(function(x$, y$){
    return x$ * y$;
  }), 1);
  maximum = function(as){
    throw Error('unimplemented');
  };
  minimum = function(as){
    throw Error('unimplemented');
  };
  iterate = curry$(function(f, initial){
    throw Error('unimplemented');
  });
  repeat = function(a){
    throw Error('unimplemented');
  };
  replicate = curry$(function(k, a){
    throw Error('unimplemented');
  });
  cycle = function(as){
    throw Error('unimplemented');
  };
  take = curry$(function(k, as){
    throw Error('unimplemented');
  });
  drop = curry$(function(k, as){
    throw Error('unimplemented');
  });
  takeWhile = curry$(function(predicate, as){
    throw Error('unimplemented');
  });
  dropWhile = curry$(function(predicate, as){
    throw Error('unimplemented');
  });
  splitAt = curry$(function(k, as){
    throw Error('unimplemented');
  });
  span = curry$(function(predicate, as){
    throw Error('unimplemented');
  });
  break1 = curry$(function(predicate, as){
    throw Error('unimplemented');
  });
  contains = curry$(function(a, as){
    throw Error('unimplemented');
  });
  find = curry$(function(predicate, as){
    throw Error('unimplemented');
  });
  filter = curry$(function(predicate, as){
    throw Error('unimplemented');
  });
  partition = curry$(function(predicate, as){
    throw Error('unimplemented');
  });
  zip = function(){
    var as;
    as = slice$.call(arguments);
    throw Error('unimplemented');
  };
  zipWith = curry$(function(f, _){
    throw Error('unimplemented');
  });
  unzip = function(ass){
    throw Error('unimplemented');
  };
  module.exports = {
    fold: fold,
    foldl: foldl,
    head: head,
    tail: tail,
    last: last,
    nth: nth
  };
  function curry$(f, bound){
    var context,
    _curry = function(args) {
      return f.length > 1 ? function(){
        var params = args ? args.concat() : [];
        context = bound ? context || this : this;
        return params.push.apply(params, arguments) <
            f.length && arguments.length ?
          _curry.call(context, params) : f.apply(context, params);
      } : f;
    };
    return _curry();
  }
}).call(this);
