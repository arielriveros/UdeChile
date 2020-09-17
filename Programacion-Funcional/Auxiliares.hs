{-
AUX 1
-}

--P1

{-
['a','b','c'] :: [Char]
('a','b','c') :: (Char, Char, Char)
[(False,'0'),(True,'1')] :: [(Bool, Char)]
[tail, init, reverse] :: [[a]->[a]]
-}

--P2

bools :: [Bool]
bools = [True, False]

nums :: [[Int]]
nums = [[1],[2],[1,2]]

copy :: a-> (a,a)
copy a = (a,a)

apply :: (a->b) -> a -> b
apply f a = f a

--P3

halve :: [a] -> ([a],[a])
halve xs = (splitAt ((length xs)`div`2) xs )

--P4

thirdHT :: [a] -> a
thirdHT xs = head (tail (tail xs))

thirdPM :: [a] -> a
thirdPM (_:_:x:xs) = x

--P6

luhnDouble :: Int-> Int 
luhnDouble d | (2 * d) > 9 = 2 * d - 9
             | otherwise = 2 * d

luhn :: Int -> Int -> Int -> Int -> Bool
luhn a b c d | condition = True
             | otherwise = False
            where condition = mod (sum (map luhnDouble [b,c,d])) 10 == 0


{-
AUX 2
-}

--P2
