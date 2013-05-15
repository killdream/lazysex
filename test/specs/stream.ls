spec     = (require 'brofist')!
{expect} = require 'chai'
Stream   = require '../../lib/stream'

module.exports = spec '{} Stream' (it, spec) ->
  one   = Stream.make 1
  two   = Stream.make 2
  three = Stream.make 3
  inc   = (+ 1)

  spec ':: Semigroup' (it) ->
    it 'associativity: a.concat(b).concat(c) ≍ a.concat(b.concat(c))' ->
      as = one.concat(two).concat(three)
      bs = one.concat(two.concat(three))

      expect (as.to-string!) .to.equal (bs.to-string!)

  spec ':: Monoid' (it) ->
    it 'right identity: m.concat(m.empty()) ≍ m' ->
      as = one.concat one.empty!
      expect (as.to-string!) .to.equal (one.to-string!)

    it 'left identity: m.empty().concat(m) ≍ m' ->
      as = one.empty!.concat one
      expect (as.to-string!) .to.equal (one.to-string!)

  spec ':: Functor' (it) ->
    it 'identity: u.map(a => a) ≍ u' ->
      expect ((one.map -> it).to-string!) .to.equal (one.to-string!)

    it 'composition: u.map(x => f(g(x))) ≍ u.map(g).map(f)' ->
      a = one.map -> (inc (inc it))
      b = one.map inc .map inc
      expect a.to-string! .to.equal b.to-string!

  spec ':: Chain' (it) ->
    it 'associativity: m.chain(f).chain(g) ≍ m.chain(x => f(x).chain(g))' ->
      f = (x) -> two
      g = (x) -> three
      a = one.chain(f).chain(g)
      b = one.chain -> f(it).chain g

      expect a.to-string! .to.equal b.to-string!

  spec ':: Monad' (it) ->
    it 'left identity: m.of(a).chain(f) ≍ f(a)' ->
      f = (x) -> Stream.make x + 1
      a = one.of 2 .chain f

      expect a.to-string! .to.equal (f 2).to-string!
    
    it 'right identity: m.chain(m.of) ≍ m' ->
      a = one.chain one.of
      expect a.to-string! .to.equal one.to-string!


