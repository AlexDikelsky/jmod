import Types

foldUnless : (Expr -> Expr -> Either Expr String) -> Expr -> List Expr -> Either Expr String
foldUnless f i [] = Left i
foldUnless f i (x :: xs) =
  case foldUnless f i xs of
       Left r => f x r
       Right r => Right r

-- toTwoArgs : Expr -> Either (Expr -> Expr -> Either Expr String) String
-- toTwoArgs (Function f) = 
--   Left $ \x => \y => f $ ConsList (x :: (y :: Nil))
-- toTwoArgs n = Right $ (show n) ++ " is not a function, so it cant have two args"

-- fold : Expr -> Expr -> Expr -> Either Expr String
-- fold (Function f) _ (Array0 l) = f (Array0 l)
-- fold (Function f) i (Array1 (x :: xs)) = 
--   case toTwoArgs (Function f) of
--        Left f => fold f (f 
--        Right r => Right r
-- 
-- fold _ _ s = Right "Unimplemted fold on " ++ (show s)
