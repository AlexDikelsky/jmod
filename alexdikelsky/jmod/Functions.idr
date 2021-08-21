module Functions

import Types
import Data.Nat

mapUnless : (a -> Either b String) -> List a -> Either (List b) String
mapUnless f [] = Left []
mapUnless f (x :: xs) =
  case (f x, mapUnless f xs) of
       (Left a, Left b) => Left $ a :: b
       (Right a, _) => Right $ show a
       (_, Right a) => Right $ show a

all2d : (a -> Either b String) -> List (List a) -> Either (List (List b)) String
all2d f l = mapUnless (\x => mapUnless f x) l


nonToExpr : Either NonRec String -> Either Expr String
nonToExpr (Left x) = Left $ Array0 x
nonToExpr (Right x) = Right x

addNumbers : NonRec -> NonRec -> Either NonRec String
addNumbers (Natural n) (Natural k) = Left $ Natural $ n + k
addNumbers (Natural n) (Finite k m1) = Left $ Finite ((n + k) `mod` m1) m1
addNumbers (Finite n m1) (Natural k) = addNumbers (Finite n m1) (Natural k)
addNumbers (Finite n m1) (Finite k m2)= 
  if m2 == m1 then Left $ Finite ((n + k) `mod` m1) m1
              else Right $ "Added numbers with modulus " ++ (show m1) ++ " and " ++ (show m2)


addVec : List NonRec -> List NonRec -> Either (List NonRec) String
addVec Nil Nil = Left Nil
addVec (x :: xs) (y :: ys) = 
  case (addNumbers x y, addVec xs ys) of
       (Left a, Left b) => Left $ a :: b
       _ => Right "Failed to add Vec"
addVec _ _ = Right "Length Error"


addVecToMat : List NonRec -> List (List NonRec) -> Either (List (List NonRec)) String
addVecToMat vec mat = mapUnless (addVec vec) mat

addMatToMat : List (List NonRec) -> List (List NonRec) -> Either (List (List NonRec)) String
addMatToMat Nil Nil = Left Nil
addMatToMat (x :: xs) (y :: ys) = 
  case (addVec x y, addMatToMat xs ys) of
       (Left a, Left b) => Left $ a :: b
       _ => Right "Yikes ...."
addMatToMat _ _ = Right "oof"



public export
add : Expr -> Either Expr String
add (Array0 n) = Left $ Array0 n
add (Array1 n) = Left $ Array1 n
add (Array2 n) = Left $ Array2 n

add (ConsList Nil) = Left $ Array0 $ Natural 0
add (ConsList (x :: Nil)) = Left x
add (ConsList (x :: xs)) = 
  case (x, add (ConsList xs)) of
     (Array0 n, Left (Array0 k)) => nonToExpr $ addNumbers n k
     (Array0 n, Left (Array1 k)) => 
         case mapUnless (addNumbers n) k of
              Left l => Left $ Array1 l
              Right r => Right r
     (Array0 n, Left (Array2 twod)) =>
         case all2d (addNumbers n) twod of
              Left s =>  Left (Array2 s)
              Right k => Right $ "Not" ++ show k

     (Array2 n, Left (Array2 m)) =>
         case addMatToMat n m of
              Left s =>  Left (Array2 s)
              Right k => Right $ "Not" ++ show k

     (Array1 n, Left (Array1 k)) => 
            case addVec n k of
                 Left e => Left $ Array1 e
                 Right f => Right f
     (Array1 n, Left (Array2 k)) => 
            case addVecToMat n k of
                 Left e => Left $ Array2 e
                 Right f => Right f


     (Array1 k, Left (Array0 n)) => add (ConsList ((Array0 n) :: ((Array1 k) :: Nil)))
     (Array2 k, Left (Array0 n)) => add (ConsList ((Array0 n) :: ((Array2 k) :: Nil)))
     (Array2 k, Left (Array1 n)) => add (ConsList ((Array1 n) :: ((Array2 k) :: Nil)))
     (a, b) => Right $ "First " ++ (show a) ++ " second " ++ (show b)

add e = Right $ "Not implemented " ++ show e
