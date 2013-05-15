-- * Lazysex API

-- Base lazy stream

type semigroup S
  concat a :: (S a) => S a -> S a

type monoid M
  empty :: () -> M

type functor F
  map :: (F a) => (a -> b) -> F b

type chain C
  chain :: (C a) => (a -> C b) -> C b

type monad M
  of :: a -> M a

implement Stream a : semigroup a, monoid a, functor a, chain a, monad a


-- Functions to operate on streams
replicate :: stream a -> int -> stream a
iterate :: (a -> b) -> a -> stream b
cycle :: stream a -> stream a
interleave :: stream a... -> stream a
interpose :: a -> stream a -> stream a

concat :: stream a... -> stream a
distinct :: stream a -> stream a -- | verify an efficient implementation using some sort of set
filter :: (a -> bool) -> stream a -> stream a
remove :: (a -> bool) -> stream a -> stream a

reduce :: (b, a -> b) -> strem a -> b

head :: stream a -> Maybe a
tail :: stream a -> stream a
take :: int -> stream a -> stream a
takeWhile :: (a -> bool) -> stream a -> stream a
drop :: int -> stream a -> stream a
dropWhile :: (a -> bool) -> stream a -> stream a
butLast :: stream a -> stream a
last :: stream a -> Maybe a
