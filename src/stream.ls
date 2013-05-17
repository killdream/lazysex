## Module stream
#
# Monadic stream implementation.
#
# 
# Copyright (c) 2013 Quildreen "Sorella" Motta <quildreen@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# -- Dependencies ------------------------------------------------------
{ Base } = require 'boo'

### {} Stream a
Stream = Base.derive {

  # :: @stream a => a, a -> stream a
  init: (head, tail) ->
    @head = head
    @tail = tail
    this

  # :: () -> string
  to-string: -> "<Stream #{@head}:#{@tail!}>"

  # ---- Semigroup -----------------------------------------------------
  # :: @stream a => stream a -> stream a
  concat: (as) ->
    | as     is Nothing  => this
    | this   is Nothing  => as
    | @tail! is Nothing  => @derive { tail: -> as }
    | otherwise          => @derive { tail: ~> @tail!concat as }

  # ---- Monoids -------------------------------------------------------  
  # :: () -> stream a
  empty: -> Nothing

  # ---- Functors ------------------------------------------------------
  # :: @stream a => (a -> b) -> stream b
  map: (f) -> do
              rest = @tail!
              @derive do
                      head: (f @head)
                      tail: if rest is Nothing => -> Nothing
                            else               => ~> rest.map f

  # ---- Chain ---------------------------------------------------------
  # :: @stream a => (a -> stream a) -> stream a
  chain: (f) -> f @head

  # ---- Monad ---------------------------------------------------------
  # :: a -> stream a
  'of': (a) -> Stream.make a, -> Nothing

  # ---- Foldable ------------------------------------------------------
  # :: @stream a => (a, b -> b) -> b -> b
  reduce-right: (f, initial) ->
    | this   is Nothing  => initial
    | @tail! is Nothing  => f @head, -> initial
    | otherwise          => f @head, ~> @tail!reduce-right f, initial

  # :: @stream a => (b, a -> b) -> b -> b
  reduce: (f, accumulated) ->
    if this is Nothing => accumulated

    s = this
    while s isnt Nothing
      accumulated = f accumulated, s.head
      rest = s.tail!
      if rest is Nothing => break
      else               => s = rest

    return accumulated
}

Nothing           = Stream.make void, -> Nothing
Nothing.to-string = -> '(Nothing)'




### -- Exports ---------------------------------------------------------
module.exports = { Stream, Nothing }
