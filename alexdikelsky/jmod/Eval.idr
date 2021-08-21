module Eval

import Types
import Functions
import Fold

import Data.Nat
import Data.List

toStrings : Expr -> Either (List String) String
toStrings (ConsList syms) = 
  mapUnless 
    (\x => case x of
      Symbol s => Left s
      z => Right $ (show z) ++ " is not a symbol")
    syms
toStrings a = Right $ (show a) ++ "is not a list"


lookupName : String -> Expr -> Expr -> Either Expr String
lookupName sym symList (ConsList valueList) =
  case toStrings symList of
    Left symbols => case lookup sym (zip symbols valueList) of
       Just v => Left v
       Nothing => Right $ "Failed to find " ++ (show sym)
    Right s => Right s
lookupName s _ _ = Right $ "Incorrect args for lookup of " ++ (show s)

symValue : String -> Context -> Either Expr String
symValue s ctx = 
  case lookup s ctx of
       Just v => Left v
       Nothing => Right $ "Couldn't find " ++ s

mutual
  exprListValue : List Expr -> Expr -> Expr -> Either (List Expr) String
  exprListValue Nil _ _ = Left Nil
  exprListValue (x :: xs) syms values =
    case (exprValue x syms values, exprListValue xs syms values) of
         (Left e, Left r) => Left $ e :: r
         _ => Right "Sorry."
  
  exprValue : Expr -> Expr -> Expr -> Either Expr String
  exprValue (Array0 k) syms values = Left $ Array0 k
  exprValue (Array1 k) syms values = Left $ Array1 k
  exprValue (Array2 k) syms values = Left $ Array2 k

  exprValue (Symbol x) syms values = lookupName x syms values
  exprValue (Quoted x) syms values = Left x
  exprValue (Function f) syms values = Left $ Function f
  
  -- exprValue (ConsList (Symbol "λ" :: (ConsList syms) :: body :: Nil)) ctx =
  --   Left $ (ConsList [Symbol "*closure*", (ConsList syms), body, ctx])

  exprValue (ConsList Nil) syms values = Right "Called ()"
  exprValue (ConsList (x::xs)) syms values =
    case (exprValue x syms values, exprListValue xs syms values) of
         (Left (Function f), Left args) => f (ConsList args)
         _ => Right "Tried to call a non-function"


public export
jValue : Expr -> Either Expr String
jValue k =
  exprValue k (ConsList (map (\x => Symbol x) ["+", "*", "%", "i.",  "/", "|:", "="]))
              (ConsList (map (\x => Function x) [add, mult, div, iota, foldUse, trans, eq]))
