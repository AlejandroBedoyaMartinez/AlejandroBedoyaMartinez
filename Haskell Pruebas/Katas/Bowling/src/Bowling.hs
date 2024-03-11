module Bowling where

data Frame = Open Int Int
            | Spare Int Int
            | Strike Int Int
            deriving (Eq, Show)
toFrames :: [Int] -> [Frame]
toFrames (x:y:ys) = Open x y : toFrames ys
toFrames [] = []