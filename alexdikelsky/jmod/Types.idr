module Types

import NumberTheory
import Data.Nat


public export
data NonRec =
  Natural Nat
| Gaussian Integer Integer
| Finite Nat Nat

public export
data Expr =
  Array0 NonRec
| Array1 (List NonRec)
| Array2 (List (List NonRec))
| ConsList (List Expr)
| Function (Expr -> Either Expr String)
| Symbol String

public export
truth : NonRec
truth = Finite 1 2

public export
falsehood : NonRec
falsehood = Finite 0 2

public export
Show NonRec where
  show (Natural n) = show n
  show (Finite n k) = (show n) ++ "m" ++ (show k)
  show (Gaussian n k) = (show n) ++ "i" ++ (show k)

public export
Show Expr where
  show (Array0 z) = show z
  show (Array1 k) = "[" ++ (foldr (\x => \y => x ++ " " ++ y) "" (map show k)) ++ "]"
  show (Array2 k) = "{\n " ++ (foldr (\x => \y => x ++ "\n " ++ y) "" (map show k)) ++ "}"
  show (ConsList k) = "(" ++ (foldr (\x => \y => x ++ " " ++ y) "" (map show k)) ++ ")"
  show (Function _) = "Function"
  show (Symbol k) = k
