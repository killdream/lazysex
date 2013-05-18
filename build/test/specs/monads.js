(function(){
  var spec, expect, ref$, Stream, Nothing;
  spec = require('brofist')();
  expect = require('chai').expect;
  ref$ = require('../../../lib/stream'), Stream = ref$.Stream, Nothing = ref$.Nothing;
  module.exports = spec('{} Stream - Monads', function(it, spec){
    var one, two, three, inc;
    one = Stream.make(1, function(){
      return Nothing;
    });
    two = Stream.make(2, function(){
      return Nothing;
    });
    three = Stream.make(3, function(){
      return Nothing;
    });
    inc = (function(it){
      return it + 1;
    });
    spec(':: Semigroup', function(it){
      return it('associativity: a.concat(b).concat(c) = a.concat(b.concat(c))', function(){
        var as, bs;
        as = one.concat(two).concat(three);
        bs = one.concat(two.concat(three));
        return expect(as.toString()).to.equal(bs.toString());
      });
    });
    spec(':: Monoid', function(it){
      it('right identity: m.concat(m.empty()) = m', function(){
        var as;
        as = one.concat(one.empty());
        return expect(as.toString()).to.equal(one.toString());
      });
      return it('left identity: m.empty().concat(m) = m', function(){
        var as;
        as = one.empty().concat(one);
        return expect(as.toString()).to.equal(one.toString());
      });
    });
    spec(':: Functor', function(it){
      it('identity: u.map(a => a) = u', function(){
        return expect(one.map(function(it){
          return it;
        }).toString()).to.equal(one.toString());
      });
      return it('composition: u.map(x => f(g(x))) = u.map(g).map(f)', function(){
        var a, b;
        a = one.map(function(it){
          return inc(inc(it));
        });
        b = one.map(inc).map(inc);
        return expect(a.toString()).to.equal(b.toString());
      });
    });
    spec(':: Chain', function(it){
      return it('associativity: m.chain(f).chain(g) = m.chain(x => f(x).chain(g))', function(){
        var f, g, a, b;
        f = function(x){
          return two;
        };
        g = function(x){
          return three;
        };
        a = one.chain(f).chain(g);
        b = one.chain(function(it){
          return f(it).chain(g);
        });
        return expect(a.toString()).to.equal(b.toString());
      });
    });
    spec(':: Monad', function(it){
      it('left identity: m.of(a).chain(f) = f(a)', function(){
        var f, a;
        f = function(x){
          return Stream.make(x + 1, function(){
            return Nothing;
          });
        };
        a = one.of(2).chain(f);
        return expect(a.toString()).to.equal(f(2).toString());
      });
      return it('right identity: m.chain(m.of) = m', function(){
        var a;
        a = one.chain(one.of);
        return expect(a.toString()).to.equal(one.toString());
      });
    });
    return spec(':: Foldable', function(it){});
  });
}).call(this);
