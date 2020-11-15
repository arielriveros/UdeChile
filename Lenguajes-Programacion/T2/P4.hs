{-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 P4 - TAREA 2                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOMBRE APELLIDO: Ariel Riveros
-}

binom :: (Integer,Integer) -> Integer
binom (m,k) | m == 0 && k == 0                       = 1 
            | (m > 0 && k == 0) || (m == 0 && k > 0) = 0
            | m == k                                 = 1
            | k > m                                  = 0
            | otherwise = binom (m - 1, k - 1) + k * binom (m - 1, k)

level :: Integer -> [Integer]
level i = [ binom (i-1,j) | j <- [0..i-1] ]


triangulo_stirling :: [[Integer]]
triangulo_stirling = [level i | i <- [1..]]