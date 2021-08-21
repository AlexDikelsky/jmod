module Functions

import Types
import BinaryOperations
import Fold
import Data.List

import Debug.Trace


mapUnless : (a -> Either b String) -> List a -> Either (List b) String
mapUnless f [] = Left []
mapUnless f (x :: xs) =
  case (f x, mapUnless f xs) of
       (Left a, Left b) => Left $ a :: b
       (Right a, _) => Right $ show a
       (_, Right a) => Right $ show a

map2d : (a -> Either b String) -> List (List a) -> Either (List (List b)) String
map2d f l = mapUnless (\x => mapUnless f x) l


nonToExpr : Either NonRec String -> Either Expr String
nonToExpr (Left x) = Left $ Array0 x
nonToExpr (Right x) = Right x


mapVec : (NonRec -> NonRec -> Either NonRec String) -> List NonRec -> List NonRec -> Either (List NonRec) String
mapVec _ Nil Nil = Left Nil
mapVec f (x :: xs) (y :: ys) = 
  case (f x y, mapVec f xs ys) of
       (Left a, Left b) => Left $ a :: b
       _ => Right "Failed to add Vec"
mapVec _ _ _ = Right "Length Error"

mapMatToMat : (NonRec -> NonRec -> Either NonRec String) -> List (List NonRec) -> List (List NonRec) -> Either (List (List NonRec)) String
mapMatToMat _ Nil Nil = Left Nil
mapMatToMat f (x :: xs) (y :: ys) = 
  case (mapVec f x y, mapMatToMat f xs ys) of
       (Left a, Left b) => Left $ a :: b
       _ => Right "Yikes ...."
mapMatToMat _ _ _ = Right "oof"


mapVecToMat : (NonRec -> NonRec -> Either NonRec String) -> List NonRec -> List (List NonRec) -> Either (List (List NonRec)) String
mapVecToMat f vec mat = mapUnless (mapVec f vec) mat

mapF : (NonRec -> NonRec -> Either NonRec String) -> 
         (Either Expr String) 
         -> Expr 
         -> Either Expr String
mapF f i (ConsList Nil) = i
mapF f i (ConsList (x :: Nil)) = Left x -- check
mapF f i (ConsList (x :: xs)) = 
  case (x, mapF f i (ConsList xs)) of
     (Array0 n, Left (Array0 k)) => nonToExpr $ f n k
     (Array0 n, Left (Array1 k)) => 
         case mapUnless (f n) k of
              Left l => Left $ Array1 l
              Right r => Right r
     (Array0 n, Left (Array2 twod)) =>
         case map2d (f n) twod of
              Left s =>  Left (Array2 s)
              Right k => Right $ "Not" ++ show k

     (Array2 n, Left (Array2 m)) =>
         case mapMatToMat f n m of
              Left s =>  Left (Array2 s)
              Right k => Right $ "Not" ++ show k

     (Array1 n, Left (Array1 k)) => 
            case mapVec f n k of
                 Left e => Left $ Array1 e
                 Right f => Right f
     (Array1 n, Left (Array2 k)) => 
            case mapVecToMat f n k of
                 Left e => Left $ Array2 e
                 Right f => Right f

     (Array1 k, Left (Array0 n)) => mapF f i (ConsList ((Array0 n) :: ((Array1 k) :: Nil)))
     (Array2 k, Left (Array0 n)) => mapF f i (ConsList ((Array0 n) :: ((Array2 k) :: Nil)))
     (Array2 k, Left (Array1 n)) => mapF f i (ConsList ((Array1 n) :: ((Array2 k) :: Nil)))
     (a, b) => Right $ "First " ++ (show a) ++ " second " ++ (show b)
mapF _ e _ = Right $ "Not implemented " ++ show e

public export
iota : Expr -> Either Expr String
iota (ConsList Nil) = Right "No argument supplied to i."
iota (ConsList (Array0 (Natural x) :: Nil)) = 
  Left $ Array1 $ case x of
       0 => []
       x => (map (\x => Natural (cast x)) [0 .. ((cast x) - 1)])
iota _ = Right "Wrong argments applied to iota"

public export
add : Expr -> Either Expr String
add = mapF addNumbers $ Left $ Array0 $ Natural 0

public export
mult : Expr -> Either Expr String
mult = mapF multNumbers $ Left $ Array0 $ Natural 1

public export
div : Expr -> Either Expr String
div = mapF divNumbers $ Left $ Array0 $ Natural 1

public export
eq : Expr -> Either Expr String
eq = mapF eqNumbers $ Left $ Array0 $ truth

public export
trans : Expr -> Either Expr String
trans (ConsList ((Array2 x) :: Nil)) = Left (Array2 (transpose x))
trans a = Right $ "Called Transpose on non matrix " ++ show a

public export
fold : Expr -> Expr -> Expr -> Either Expr String
fold (Function f) _ (Array0 l) = f (Array0 l)
fold (Function f) i (Array1 Nil) = Left i
fold (Function f) i (Array1 (x :: xs)) =
  case fold (Function f) i (Array1 xs) of
     Left r => f (ConsList [Array0 x, r])
     Right r => Right r

fold (Function f) i (Array2 Nil) = Left i
fold (Function f) i (Array2 (x :: xs)) =
  case fold (Function f) i (Array2 xs) of
    Left r => f (ConsList [Array1 x, r])
    Right r => Right r

fold _ _ s = Right $ "Unimplemted fold on " ++ (show s)

public export
foldUse : Expr -> Either Expr String
foldUse (ConsList ((Function f) :: (i :: (xs :: Nil)))) =
  fold (Function f) i xs

foldUse f = Right $ "Failed on folduse" ++ (show f)

