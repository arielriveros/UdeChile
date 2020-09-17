{-Example for Fibonacci Sequence with parallel programming-}

import Control.Parallel.Strategies

fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)


fibPar1 :: [Integer]
fibPar1 = parMap rpar fib [0..40]


main :: IO ()
main = do
    let x = fibPar1
    print x
    return ()