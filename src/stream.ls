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

Nothing = { to-string: -> '(Nothing)' }

### {} Stream a
Stream = Base.derive {

  # :: @stream a => a -> stream a
  init: (x) ->
    @head = x
    @tail = -> Nothing
    this

  # :: () -> string
  to-string: -> "<Stream #{@head}:#{@tail?!}>"

  # ---- Semigroup -----------------------------------------------------
  # :: @stream a => stream a -> stream a
  concat: (as) ->
    | as.head is Nothing => this
    | @head is Nothing   => as
    | @tail! is Nothing  => @derive { tail: -> as }
    | otherwise          => @derive { tail: ~> @tail!concat as }

  # ---- Monoids -------------------------------------------------------  
  # :: () -> stream a
  empty: -> @make Nothing

  # ---- Functors ------------------------------------------------------
  # :: @stream a => (a -> b) -> stream b
  map: (f) -> @derive do
                      head: (f @head)
                      tail: ~> if @tail! isnt Nothing => @tail!map f
                               else                   => Nothing

  # ---- Chain ---------------------------------------------------------
  # :: @stream a => (a -> stream a) -> stream a
  chain: (f) -> f @head

  # ---- Monad ---------------------------------------------------------
  # :: a -> stream a
  'of': (a) -> Stream.make a
}




### -- Exports ---------------------------------------------------------
module.exports = Stream
