-- * Lazysex API

-- Base lazy stream

type semigroup s
  concat A :: (s A) => s A -> s A

type monoid m
  empty :: () -> m

type functor f
  map :: (f A) => (A -> B) -> f B

type chain c
  chain :: (c A) => (A -> c B) -> c B

type monad m
  of :: A -> m A

implement stream A : semigroup A, monoid A, functor A, chain A, monad A


-- Accessing items from a stream
head :: stream A -> maybe A
last :: stream A -> maybe A
tail :: stream A -> stream A
butLast :: stream A -> stream A
nth :: int -> stream A -> maybe A
indexOf :: A -> stream A -> int


-- Inspecting properties of a stream
length :: stream A -> int
isEmpty :: stream A -> bool

-- Transforming a stream
map :: (A -> B) -> stream A -> stream B
reverse :: stream A -> stream A
interpose :: A -> stream A -> stream A
interleave :: stream A... -> stream A

-- Reducing streams
fold :: (B, A -> B) -> B -> stream A -> B
foldRight :: (B, A -> B) -> B -> stream A -> B

-- Special folds
concat :: stream A... -> stream A
mapConcat :: (A -> stream B) -> stream A -> stream B
and :: stream bool -> bool
or :: stream bool -> bool
any :: (A -> bool) -> stream A -> bool
all :: (A -> bool) -> stream A -> bool
sum :: stream number -> number
product :: stream number -> number
maximum :: stream number -> number
minimum :: stream number -> number

-- Building streams
iterate :: (A -> A) -> A -> stream A
repeat :: A -> stream A
replicate :: int -> A -> stream A
cycle :: stream A -> stream A

-- Extracting parts of a stream
take :: int -> stream A -> stream A
drop :: int -> stream A -> stream A
takeWhile :: (A -> bool) -> stream A -> stream A
dropWhile :: (A -> bool) -> stream A -> stream A
splitAt :: int -> stream A -> #[stream A, stream A]
span :: (A -> bool) -> stream A -> #[stream A, stream A]
break :: (A -> bool) -> stream A -> #[stream A, stream A]

-- Searching things on streams
contains :: A -> stream A -> bool
find :: (A -> bool) -> stream A -> maybe A
filter :: (A -> bool) -> stream A -> stream A
partition :: (A -> bool) -> stream A -> #[stream A, stream A]

-- Zipping streams
zip :: stream A... -> [[stream A]]
zipWith :: (A... -> B) -> stream A... -> [[stream B]]
unzip :: [[stream A]] -> [[stream A]]
