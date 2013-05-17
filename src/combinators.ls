## Module combinators
#
# Combinators for working with Streams.
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
{ Nothing } = require './stream'


# -- Reducing streams --------------------------------------------------

# :: (A, B -> B) -> B -> stream A -> B
fold = (f, initial, xs) --> xs.reduce-right f, initial

# :: (B, A -> B) -> B -> stream A -> B
foldl = (f, initial, xs) --> xs.reduce f, initial


# -- Accessing items from a Stream -------------------------------------

# :: stream A -> maybe A
head = (xs) -> xs.head

# :: stream A -> stream A
tail = (xs) -> xs.tail!

# :: stream A -> maybe A
last = foldl ((a) -> a), void

# :: stream A -> maybe A
nth = (n, xs) -->
  while --n and ((xs := xs.tail!) isnt Nothing) => void
  xs.head

# stream A -> stream A
but-last = (xs) -> ...

# A -> stream A -> int
index-of = (x, xs) --> ...


# -- Inspecting properties of a Stream ---------------------------------

# :: stream A -> int
length = foldl (+ 1), 0

# :: stream A -> bool
is-empty = (is Nothing)


# -- Transforming a Stream ---------------------------------------------

# :: (A -> B) -> stream A -> stream B
map = (f, as) --> as.map f

# :: stream A -> stream A
reverse = (f, as) --> ...

# :: A -> stream A -> stream A
interpose = (separator, as) --> ...

# :: stream A... -> stream A
interleave = (xs...) -> ...


# -- Special folds -----------------------------------------------------

# :: stream A... -> stream A
concat = (xs...) -> ...

# :: (A -> stream B) -> stream A -> stream B
map-concat = (f, xs) -> ...

# :: (A -> bool) -> stream A -> bool
any = (f, as) -> ...

# :: (A -> bool) -> stream A -> bool
all = (f, as) -> ...

# :: stream number -> number
sum = foldl (+), 0

# :: stream number -> number
product = foldl (*), 1

# :: stream number -> number
maximum = (as) -> ...

# :: stream number -> number
minimum = (as) -> ...


# -- Building streams --------------------------------------------------

# :: (A -> A) -> A -> stream A
iterate = (f, initial) -> ...

# :: A -> stream A
repeat = (a) -> ...

# :: int -> A -> stream A
replicate = (n, a) -> ...

# :: stream A -> stream A
cycle = (as) -> ...


# -- Exports -----------------------------------------------------------
module.exports = {
  fold, foldl

  head, tail, last, nth
}
  
  
