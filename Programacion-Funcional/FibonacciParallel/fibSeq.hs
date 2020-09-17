{-Example for Fibonacci Sequence without parallel programming-}

fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fibSeq :: Integer
fibSeq = (fib 36 + fib 30)

main :: IO ()
main = do
    let x = fibSeq
    print x
    return ()