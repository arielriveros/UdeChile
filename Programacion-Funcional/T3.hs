{-------------------------------------------}
{--------------  EJERCICIO 1  --------------}
{-------------------------------------------}

-- Parte (a)


apps :: Double  -> Double -> [Double]
-- Azúcar sintáctico
-- apps ao r = [a0, a1, a2,...]
-- apps a0 r = [a0, paso a0 r,---] -- paso a0 r = 0.5(a0 + r/a0)
-- apps a0 r = a0:(paso a0 r):(paso (paso a0 r) r),...
apps a0 r = a0:(apps s r)
            where s = 0.5*(a0+r/a0)

-- Parte (b)
approxLimit :: Double -> [Double] -> Double
approxLimit e an | head an - head (tail an) <= e = head (tail an)
                 | otherwise = approxLimit e (tail an)

-- Parte (c)
approxSqrt :: Double -> Double -> Double -> Double
approxSqrt n a0 e = approxLimit e (tail (apps a0 n))



{-------------------------------------------}
{--------------  EJERCICIO 2  --------------}
{-------------------------------------------}

data Tree a = Node a [Tree a]

-- Parte (a)
itTree :: (a -> [a]) -> a -> Tree a
itTree func root = Node root t where t = map (itTree func) (func root)

-- Lista infinita de sucesores definida como en (a)
serie :: Num a => a -> [a]
serie s = (s+1):(serie (s+1))

-- Parte (b)
infTree :: Tree Integer
infTree = itTree serie 0



{-------------------------------------------}
{--------------  EJERCICIO 3  --------------}
{-------------------------------------------}
{-
f :: [Int] -> (Int, Int) -> (Int, Int)
f []     c = c
f (x:xs) c = f xs (step x c)

step :: Int -> (Int,Int) -> (Int, Int)
step n (c0, c1) | even n    = (c0, c1 + 1)
                | otherwise = (c0 + 1, c1)
-}

-- Parte (a): call-by-value
{-
  f [1,2,3,4] (0,1)
= f [2,3,4] (step 1 (0,1))
= f [2,3,4] (0+1,1)
= f [2,3,4] (1,1)
= f [3,4] (step 2 (1,1))
= f [3,4] (1,1+1)
= f [3,4] (1,2)
= f [4] (step 3 (1,2))
= f [4] (1+1,2)
= f [4] (2,2)
= f [] (step 4 (2,2))
= f [] (2,2+1)
= f [] (2,3)
= (2,3)
-}

-- Parte (b): lazy evaluation
{-
  f [1,2,3,4] (0,1)
= _
= f _ _
= f x:xs _ -- x:xs no vacío
= f x:xs (_,_) 
= f [1,2,3,4] (_,_)
= f [1,2,3,4] (0,1)
= f [2,3,4] (step 1 (0,1))
= f [3,4] (step 2 (step 1 (0,1)))
= f [4] (step 3 (step 2 (step 1 (0,1))))
= f [] (step 4 (step 3 (step 2 (step 1 (0,1)))))
= step 4 (step 3 (step 2 (step 1 (0,1))))
= step 4 (step 3 (step 2 (0+1,1)))
= step 4 (step 3 (0+1,1+1))
= step 4 ((0+1)+1,1+1)
= ((0+1)+1,(1+1)+1)
= (1+1,(1+1)+1)
= (1+1,2+1)
= (2,2+1)
= (2,3)

-}

{-------------------------------------------}
{--------------  EJERCICIO 4  --------------}
{-------------------------------------------}
-- Parte (a)
{-
Sí, presenta un space leak. Cada reducción de la expresión genera otra donde sus argumentos
no son evaluados hasta que se cumpla el caso base de la función f, donde se comienza a reducir
evaluando f a cada argumento más interior.  
-}


-- Parte (b)

f :: [Int] -> (Int, Int) -> (Int, Int)
f []     c = c
f (x:xs) c = let r = c `seq` step x c in f xs r

--step no se cambia
step :: Int -> (Int, Int) -> (Int,Int)
step n (c0,c1) | even n = (c0,c1+1)
               | otherwise = (c0+1,c1)


-- Parte (c)
{-
Haciendo lazy evaluation

length [1..10]
= length2 0 [1..10]
= length2 1 [2..10]
= length2 (1+1) [3..10]
= length2 ((1+1)+1) [4..10]
= length2 (((1+1)+1)+1) [5..10]
= ...
= length2 ((((((((1+1)+1)+1)+1)+1)+1)+1)+1) [10]
= length2 (((((((((1+1)+1)+1)+1)+1)+1)+1)+1)+1) []
= (((((((((1+1)+1)+1)+1)+1)+1)+1)+1)+1)
= ...
= 10

Claramente hay space leak, la reducción de la expresión no es proporcional al largo de la lista
donde al final de la reducción de length2 se procede a evaluar la suma que ha devuelto la expresión

-}

-- Parte (d)
{-

length2 n [] = n
length2 n (_:xs) = let n' = n+1 in n' `seq` length2 n' xs

-}



{-------------------------------------------}
{--------------  EJERCICIO 5  --------------}
{-------------------------------------------}


partMerge1 :: (a -> Bool) -> ([a], [a]) -> ([a], [a])
partMerge1 p (xs,ys) = (filter p xs ++ filter (not . p) ys,
                       filter (not . p) xs ++ filter p ys)

partcat :: (a -> Bool) -> [a] -> ([a],[a]) -> ([a],[a])
partcat p xs (us,vs) = (filter p xs ++ us, filter (not . p) xs ++ vs)


-- Parte (a)
{-
La función partMerge realiza filtros secuenciales a ambas listas del par entregado como argumento
Esto significa que aplica la función filter 2 veces por lista y un total de 4 veces, lo que es
ineficiente en tiempo de reducción siendo que la definición de la función permite poder redefinir
el cuerpo de forma de que cada lista se recorra 1 sola vez.
-}

-- Parte (b)


partMerge :: (a -> Bool) -> ([a], [a]) -> ([a], [a])
partMerge p (xs,ys) 
-- = (filter p xs ++ filter (not . p) ys, filter (not . p) xs ++ filter p ys) {def partMerge}
-- = (filter p xs ++ (filter (not . p) ys), filter (not . p) xs ++ (filter p ys)) {asoc ++ }
  = partcat p xs (filter (not.p) ys, filter p ys)



-- Parte (c)

{-

La lógica es realizar un foldl a xs de forma que construya una tupla donde el primer elemento es una lista que
cumple la proposición p y el segundo elemento es otra lista que no cumple la proposición p

Esta tupla se va construyendo a la vez que se evalua cada elemento de la lista, así para cada elemento en una
lista xs le corresponde un valor para ambos valores de la tupla, uno con (p) y otro con (not.p)

-}

--partcat1 :: (a -> Bool) -> [a] -> ([a],[a]) -> ([a],[a])
--partcat1 p xs (us,vs) = (foldl ((++).(filter p)) [] xs,[])

-- Parte (d)
{-
Si se reemplaza foldl con foldl' significará para la función una liberación de espacio, foldl' forzará a la función
que a cada elemento de la lista sea evaluada con la función filter inmediatamente. 

-}



{-------------------------------------------}
{--------------  EJERCICIO 6  --------------}
{-------------------------------------------}

h :: Int -> Int
h 0 = 2
h 1 = 3
h 2 = 4
h n = 1 + 3 * h (n-1) + 3 * h(n-3)


-- Parte (a)
{-
En el caso recursivo la función h se ejecuta dos veces
-}

-- Parte (b)
h1 :: Int -> Int
h1 0 = 2
h1 1 = 3
h1 2 = 4
h1 n = 1 + 3 * t where t = (h1 (n - 1) + h1 (n - 3))



main :: IO()
main = pure()