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

  putStrLn $ show $ jValue $ ConsList [Symbol "+", ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 3, Natural 4]],
                                                   ConsList [Symbol "+", Array0 (Natural 5), Array1 [Natural 3, Natural 4]]]

  putStrLn $ show $ ConsList [Symbol "+", ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 3, Natural 4]],
                                                   ConsList [Symbol "+", Array0 (Natural 5), Array1 [Natural 3, Natural 4]]]


  putStrLn $ show $ jValue $ ConsList [Symbol "i.", Array0 (Natural 4)]
  putStrLn $ show $ jValue $ ConsList [Symbol "i.", Array0 (Natural 0)]
  putStrLn $ show $ jValue $ ConsList [Symbol "i.", Array0 (Natural 1)]

  -- putStrLn $ show $ jValue $ ConsList [Symbol "+", ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 3, Natural 4]]]
  -- putStrLn $ show $ ConsList [Symbol "+", ConsList [Symbol "+", Array0 (Natural 1), Array1 [Natural 3, Natural 4]]]

  
  putStrLn $ show $ parseExpr "(asdf asdf)"
  putStrLn $ show $ parseExpr "[asdf asdf]"
  putStrLn $ show $ parseExpr "[1 3]"
  putStrLn $ show $ parseExpr "[[1 3] [4 5]]"
  putStrLn $ show $ parseExpr "[[1 3] [4 5] 4]"
  putStrLn $ show $ parseExpr "[1_3 4 _ 4]"
  putStrLn $ show $ parseExpr "[1_3 4_4]"

  putStrLn $ test "(+ [1 3] [4 5])"
  putStrLn $ show $ parseExpr "(* 3 [4 5])"
  putStrLn $ test "(* 3 [4 5])"
  putStrLn $ test "(* 3 (i. 5))"
  -- putStrLn $ test "(* 1_10 (i. 5))"

  putStrLn $ test "(* 2_4 (i. 5))"
  putStrLn $ test "(+ 1_4 (* 2_4 (i. 5)))"

  -- putStrLn $ show $ jValue $ Natural 3
  -- putStrLn $ show $ jValue $ Finite 3 4
  -- putStrLn $ show $ jValue $ Finite 3 4
  -- putStrLn $ show $ jValue $ Quoted $ Array [Natural 3, Natural 4]
  -- putStrLn $ show $ jValue $ Quoted $ Array [Symbol "+", Natural 3, Natural 4]
  -- putStrLn $ show $ jValue $ Array [Symbol "+", Natural 3, Natural 4]
  -- putStrLn $ show $ jValue $ Array [Symbol "+", Natural 3, Finite 2 4]


