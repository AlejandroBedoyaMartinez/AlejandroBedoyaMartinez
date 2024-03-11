module Main where

import Test.Tasty
import Test.Tasty.HUnit
import Bowling
tests :: [(String, [Int], [Frame])]
tests =
    [ ("zeros are open 0 0"
        , replicate 20 0
        , replicate 10 (Open 0 0)
        )
    , ("ones are open 1 1"
        , replicate 20 1
        , replicate 10 (Open 1 1)
        )
    , ("4+5s are open 4 5"
        , take 20 $ cycle [4, 5]
        , replicate 10 (Open 4 5)
        )
    , ("spares in non last position"
        , let spare = [1, 9]
            opens n = take (2*n) $ cycle [3, 3]
        in spare ++ opens 2 ++ spare ++ opens 4 ++ spare ++ opens 1
        , let spare = [Spare 1 3]
            opens n = replicate n (Open 3 3)
        in spare ++ opens 2 ++ spare ++ opens 4 ++ spare ++ opens 1
        )
    , ("spare in last position"
        , take 18 (cycle [0, 0]) ++ [1, 9, 5]
        , replicate 9 (Open 0 0) ++ [Spare 1 5]
        )
        ,
    ]
bowlingSuite :: TestTree
                bowlingSuite = testGroup "Bowling tests"
                [ testGroup "toFrames" $
                    map (\(label, input, expected) ->
                        testCase label $ toFrames input @?= expected) tests
                ]
main = defaultMain bowlingSuite

