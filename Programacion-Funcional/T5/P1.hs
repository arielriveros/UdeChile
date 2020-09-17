import Data.Array
import Data.List
import Control.Parallel.Strategies 
import Control.Monad

type Coeff = Integer
type Poly = Array Int Coeff

mkPoly :: [Coeff] -> Poly
mkPoly xs = listArray (0,d) xs where d = length xs - 1

degree :: Poly -> Int
degree = snd . bounds

coeff :: Poly -> Int -> Coeff
coeff p i | i <= degree p = p ! i
          | otherwise     = 0


-- parte (a)
coeffProd :: Poly -> Poly -> Int -> Coeff
coeffProd p1 p2 i = foldl' (+) 0 r
  where aux l1 l2 n = do 
          x <- [0..n]
          return $ (coeff l1 x) * (coeff l2 (n-x))
        r | degree p1 <= degree p2 = aux p1 p2 i
          | otherwise = aux p2 p1 i

seqProd :: Poly -> Poly -> Poly
seqProd p1 p2 = do
  mkPoly (map (coeffProd p1 p2) [0..d])  where
  d = degree p1 + degree p2

-- parte (b)
{-
Total   time    0.721s  (  0.661s elapsed)
Total   time    0.693s  (  0.631s elapsed)
Total   time    0.645s  (  0.591s elapsed)
Total   time    0.664s  (  0.611s elapsed)
Total   time    0.642s  (  0.591s elapsed)

Promedio elapsed time: 0.617s
-}

-- parte (c)
parProd :: Poly -> Poly -> Poly
parProd p1 p2 = mkPoly $ join $ do
  let f n = map (coeffProd p1 p2) [n*15..n*15+14]
      d = degree p1 + degree p2
      t = [0..d `div` 15]
    in parMap rdeepseq f t

    

-- parte (d)
{-
Total   time    0.800s  (  0.412s elapsed)
Total   time    0.781s  (  0.401s elapsed)
Total   time    0.776s  (  0.401s elapsed)
Total   time    0.716s  (  0.371s elapsed)
Total   time    0.742s  (  0.381s elapsed)

Promedio elapsed time: 0.393s
-}

-- parte (e)
-- Speedup: x1.57


-- parte (f)
par1Prod :: Poly -> Poly -> Poly
par1Prod p1 p2 = mkPoly $ parMap rdeepseq (coeffProd p1 p2) [0..d]
  where d = degree p1 + degree p2

-- parte (g)
{-
Total   time    1.211s  (  0.622s elapsed)
Total   time    1.152s  (  0.581s elapsed)
Total   time    1.116s  (  0.558s elapsed)
Total   time    1.176s  (  0.601s elapsed)
Total   time    1.204s  (  0.611s elapsed)

Promedio lapsed time: 0.595s

Speedup: x1.04
-}

-- parte (h)
{-
el cómputo de coeffProd se hace de manera lazy, al hacerlo en paralelo en chunks de 15 con rdeepseq entonces
computa coeffProd forzándolo secuencialmente aprovechando 2 cores habiendo un speedup de 1.57, sin embargo
si el paralelismo se hiciera en chunks de 1 cómputo de coeficiente entonces el tiempo de computación de cada coeficiente
por spark es casi idéntico al del cómputo de cada coeffProd, al crear tantos sparks para un cómputo lazy no se
aprovecha el número de cores en su totalidad y al final es como si la creación de spark y su cómputo se hiciera en serie
respecto a la otra creación de spark y su cómputo, comportándose como si fuera secuencial
-}

-- parte (i)
{-
nonNullCoeff devuelve un Int, el cual es menos costoso que imprimir un Array de Coeffs, en ambos casos se realiza el
cálculo del producto de dos polinomios, así la diferencia es en el costo de hacer un print de un Int o de un Array
-}


-- Determina el nÃºmero de coeficientes no nulos de un polinomio
nonNullCoeff :: Poly -> Int
nonNullCoeff = foldr (\c rec -> if (c == 0) then rec else rec + 1) 0

main :: IO()
main = do
  let pa = mkPoly [100..2000]
      pb = mkPoly [2000..5000]
  print (nonNullCoeff(par1Prod pa pb))
  return ()

