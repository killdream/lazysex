spec     = (require 'brofist')!
{expect} = require 'chai'
{Stream, Nothing} = require '../../lib/stream'

module.exports = spec '{} Stream' (it, spec) ->
  one = Stream.make 1, -> Nothing
  two = Stream.make 2, -> one
 
  ones      = Stream.make 1
  ones.tail = -> ones

  spec 'init(a, b)' ->
    it 'Should produce a value matching Stream structure' ->
      expect (one.head) .to.equal 1
      expect (two.tail!head) .to.equal 1

  spec 'to-string()' ->
    it 'Should produce a textual representation of the stream.' ->
      expect (two.to-string!) .to.equal '<Stream 2:<Stream 1:(Nothing)>>'

  spec 'concat(bs)' ->
    it 'If the left stream is empty, should return the right.' ->
      expect (Nothing.concat one) .to.equal one

    it 'If the right stream is empty, should return the left.' ->
      expect (one.concat Nothing) .to.equal one

    it 'Should return the left stream, followed by the right stream.' ->
      expect (one.concat one).to-string! .to.equal '<Stream 1:<Stream 1:(Nothing)>>'

    it 'Should concatenate things lazily.' ->
      expect (ones.tail!head) .to.equal 1

  spec 'empty()' ->
    it 'Should return a new empty stream.' ->
      expect (Stream.empty!) .to.equal Nothing

  spec 'map(f)' ->
    it 'Should return a new Stream with every item transformed by `f`.' ->
      double = two.map (* 2)
      expect (double.to-string!) .to.equal '<Stream 4:<Stream 2:(Nothing)>>'
    
    it 'Should be lazy.' ->
      twos = ones.map (+ 1)
      expect (twos.tail!head) .to.equal 2

  spec 'chain(f)' ->
    it 'Should transform a Stream`s head value.' ->
      two = one.chain (a) -> Stream.of (a + 1)
      expect (two.head) .to.equal 2

  spec 'of(a)' ->
    it 'Should create a new Stream with the given head.' ->
      expect (Stream.of 1).head .to.equal 1

  spec 'reduce-right(f, a)' ->
    it 'Folding an empty list should return the initial value.' ->
      expect (Nothing.reduce-right (+ 1), 0) .to.equal 0

    it 'Should apply f to the first value, and the result of the rest.' ->
      sum = two.reduce-right (+), 0
      expect sum .to.equal 3

    it 'Should be right-associative.' ->
      as = two.reduce-right ((a, b) -> [a, b]), []
      expect as .to.deep.equal [2, [1, []]]

  spec 'reduce(f, a)' ->
    it 'Folding an empty list should return the initial value.' ->
      expect (Nothing.reduce (+ 1), 0) .to.equal 0

    it 'Should apply f to the first value, and the result of the rest.' ->
      sum = two.reduce (+), 0
      expect sum .to.equal 3

    it 'Should be left associative.' ->
      as = two.reduce ((a, b) -> [a, b]), []
      expect as .to.deep.equal [[2, []], 1]
