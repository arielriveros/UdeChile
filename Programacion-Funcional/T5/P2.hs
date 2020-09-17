import Control.Parallel.Strategies
import Control.DeepSeq
import Data.List.Split
import Data.List
import Control.Monad

type Number = Double

-- parte (a)
integral :: (Number -> Number) -> Number -> Number -> Int -> Number
integral f a b n = foldl' (+) 0 r
  where r = do
        let h = (b - a) / fromIntegral n
        x <- map fromIntegral [0..n]
        return $ ( (f (a + x*h)) + (f (a + x*h + h)) ) * h / 2

{-
Total   time    5.598s  (  5.513s elapsed)
Total   time    5.477s  (  5.405s elapsed)
Total   time    5.755s  (  5.661s elapsed)
Total   time    5.453s  (  5.381s elapsed)
Total   time    5.526s  (  5.443s elapsed)
-}

-- parte (b)

pintegral :: (Number -> Number) -> Number -> Number -> Int -> Number
pintegral f a b n = foldl1 (+) $ (map g s `using` parListChunk 50 rdeepseq)
  where
    s  = chunksOf 50 [0..fromIntegral n]
    h  = (b - a) / fromIntegral n
    g = \xs -> sum (map (\x -> ((f (a + x*h))+(f (a+x*h+h)))*h/2) xs)

{-
Total   time    5.982s  (  3.001s elapsed)
Total   time    6.102s  (  3.071s elapsed)
Total   time    6.092s  (  3.063s elapsed)
Total   time    6.221s  (  3.131s elapsed)
Total   time    6.019s  (  3.021s elapsed)
-}


-- parte (c)
-- Elapsed time sequential version: 5.481 s
-- Elapsed time parallel version: 3.057 s
-- Speedup: complete aquÃ­ : x1.79

main :: IO()
main = do
  let f = \x -> 2*x^2 + 3*x^10 - x^6 + 10*x^30 - 8*x^25
      a = 0
      b = 100
      n = 2000000
  print (pintegral f a b n)
  return ()
