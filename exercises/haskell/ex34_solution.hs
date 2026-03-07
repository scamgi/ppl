data Tape a = Tape [a] a [a] deriving Show

instance Functor Tape where
  fmap f (Tape left center right) = Tape (fmap f left) (f center) (fmap f right)

instance Applicative Tape where
  pure val = Tape [] val []

  (Tape fLeft fCenter fRight) <*> (Tape vLeft vCenter vRight) =
      Tape (zipWith ($) fLeft vLeft) (fCenter vCenter) (zipWith ($) fRight vRight)

