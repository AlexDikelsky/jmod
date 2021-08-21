module Main

import Eval
import Types
import Functions
import Parser

test : String -> String
test s =
  case parseExpr s of
       Right (x, _) => show (jValue x)
       Left k => show k

main : IO ()
main = do
  -- putStrLn $ show $ Array2 [[Natural 4], [Natural 5]]
  -- putStrLn $ show $ ConsList [Array2 [[Natural 4], [Natural 5]],  ConsList [Symbol "sfd"]]
  -- putStrLn $ show $ ConsList [Symbol "+"]
  -- putStrLn $ show $ jValue $ Symbol "sadf"
  -- putStrLn $ show $ jValue $ Quoted $ ConsList [Symbol "+", Array1 [Natural 4, Natural 4]]
  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", Array1 [Natural 4]]
  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", Array1 [Natural 4, Natural 9]]

  -- putStrLn $ show $ jValue $ 
  --      ConsList [Symbol "+", Array1 [Natural 4, Natural 9], 
  --                            Array1 [Natural 4, Natural 9]]
  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", Array0 (Natural 4), Array0 (Natural 3),
  --                                                  Array0 (Natural 5)]

  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 4, Natural 9]]

  -- putStrLn $ show $ jValue $ Array2 [[Natural 4, Natural 9], [Natural 5, Natural 6]]
  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", Array0 (Natural 20), Array2 [[Natural 4, Natural 9], [Natural 5, Natural 6]]]

  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", Array1 [Finite 1 3, Finite 2 3], Array1 [Finite 2 3, Finite 0 3]]

  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", Array1 [Natural 4, Natural 2], Array0 (Natural 3)]

  -- putStrLn $ show $ jValue $ ConsList [Symbol "*", Array1 [Natural 4, Natural 2], Array0 (Natural 3)]

  -- putStrLn $ show $ jValue $ ConsList [Symbol "*", Array1 [Natural 4, Natural 2], Array0 (Natural 3)]

  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 3, Natural 4]],
  --                                                  ConsList [Symbol "+", Array0 (Natural 5), Array1 [Natural 3, Natural 4]]]

  -- putStrLn $ show $ ConsList [Symbol "+", ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 3, Natural 4]],
  --                                                  ConsList [Symbol "+", Array0 (Natural 5), Array1 [Natural 3, Natural 4]]]


  -- putStrLn $ show $ jValue $ ConsList [Symbol "i.", Array0 (Natural 4)]
  -- putStrLn $ show $ jValue $ ConsList [Symbol "i.", Array0 (Natural 0)]
  -- putStrLn $ show $ jValue $ ConsList [Symbol "i.", Array0 (Natural 1)]

  -- -- putStrLn $ show $ jValue $ ConsList [Symbol "+", ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 3, Natural 4]]]
  -- -- putStrLn $ show $ ConsList [Symbol "+", ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 3, Natural 4]]]

  -- 
  -- putStrLn $ show $ parseExpr "(asdf asdf)"
  -- putStrLn $ show $ parseExpr "[asdf asdf]"
  -- putStrLn $ show $ parseExpr "[1 3]"
  -- putStrLn $ show $ parseExpr "[[1 3] [4 5]]"
  -- putStrLn $ show $ parseExpr "[[1 3] [4 5] 4]"
  -- putStrLn $ show $ parseExpr "[1m3 4 m 4]"
  -- putStrLn $ show $ parseExpr "[1m3 4m4]"

  -- putStrLn $ test "(+ [1 3] [4 5])"
  -- putStrLn $ show $ parseExpr "(* 3 [4 5])"
  -- putStrLn $ test "(* 3 [4 5])"
  -- putStrLn $ test "(* 3 (i. 5))"
  -- -- putStrLn $ test "(* 1m10 (i. 5))"

  -- putStrLn $ test "(* 2m4 (i. 5))"
  -- putStrLn $ test "(+ 1m4 (* 2m4 (i. 5)))"

  -- putStrLn $ test "(+ 1 [0 3m4 6m2])"
  -- putStrLn $ test "(+ 1 [0 3m4 6m2])"
  -- putStrLn $ test "(i. 4)"
  -- putStrLn $ test "(+ 0m4 (i. 8))"
  -- putStrLn $ test "(+ 3 4)"
  putStrLn $ test "(/ + 0 [3 4 5 6])"
  putStrLn $ test "(/ * 1 [1 2 3 4])"
  putStrLn $ test "(/ * 1 [1 2 3 4])"
  putStrLn $ test "(/ * 1 [[1 2 3 4] [5 6 7 8]])"
  putStrLn $ test "(|: [[1 2 3 4] [5 6 7 8]])"
  putStrLn $ test "(/ * 1 (|: [[2 3 5] [7 11 13]]))"
  putStrLn $ test "(= 1 [[2 1 5] [7 11 13]])"
  putStrLn $ test "(= 1 [2 3 5])"
  putStrLn $ test "(* (+ 0m15 (i. 16)) (+ 0m15 (i. 16)))"
  putStrLn $ test "(+ 3 [0m5 1m5 2m5 3m5 4m5])"
