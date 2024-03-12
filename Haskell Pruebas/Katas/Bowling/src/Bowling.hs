module Bowling where

data Frame = Open Int Int
           | Spare Int Int
           | Strike Int Int
           deriving (Eq, Show)

toFrames :: [Int] -> Maybe [Frame]
toFrames = go 1
  where
    go 10 [x, y]
      | x + y < 10 = Just [Open x y]
      | otherwise = Nothing
    go 10 [x, y, z]
      | x == 10 = Just [Strike y z]
      | x + y == 10 = Just [Spare x z]
      | otherwise = Nothing
    go n (x:y:z:ys)
      | x == 10 = (Strike y z :) <$> go (n+1) (y:z:ys)
      | x + y == 10 = (Spare x z :) <$> go (n+1) (z:ys)
      | x + y < 10 = (Open x y :) <$> go (n+1) (z:ys)
      | otherwise = Nothing
    go _ _ = Nothing
frameScore :: Frame -> Int
frameScore (Open x y) = x + y
frameScore (Spare _ y) = 10 + y
frameScore (Strike x y) = 10 + x + y
score :: [Frame] -> Int
score = sum . map frameScore
scorePlay :: [Int] -> Maybe Int
scorePlay pins = do
    frames <- toFrames pins
    return $ score frames

