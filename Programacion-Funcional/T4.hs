import Control.Monad.State
import Data.List
import Control.Monad
import Numeric.Probability.Distribution hiding (map,coin,filter)



{-------------------------------------------}
{--------------  EJERCICIO 1  --------------}
{-------------------------------------------}
type Matrix = [[Int]]
type Size = Int

sourceMatrix :: Matrix
sourceMatrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]

targetMatrix :: Matrix
targetMatrix = [[14,16,15,13],[6,8,7,5],[2,4,3,1],[10,12,11,9]]


-- parte (a)
swapRow :: Int -> Int -> Matrix -> Matrix
swapRow = swap

swapColumn :: Int -> Int -> Matrix -> Matrix
swapColumn x y m = m >>= \n -> [swap x y n]

swap :: Int -> Int -> [a] -> [a]
swap x y | x == y = id
         | otherwise = swap' (min x y) (max x y)

swap' :: Int -> Int -> [a] -> [a]
swap' first second lst = beginning ++ [y] ++ middle ++ [x] ++ end
  where
    (beginning, (x : r)) = splitAt first lst
    (middle, (y : end)) = splitAt (second - first - 1) r


-- parte (b)
swapM :: Size -> Matrix -> [Matrix]
swapM s matrix = do
  m <- [0..s-1]
  n <- [0..s-1]
  guard (m < n) -- Evita identidades y repetir permutaciones
  x <- return $ swapRow m n matrix
  y <- return $ swapColumn m n matrix
  [x,y]


-- parte (c)
swapMUntil :: Size -> (Matrix -> Bool) -> (Int, [Matrix]) -> (Int, [Matrix])
swapMUntil s cond (n, m) | c          = (n, m)
                         | otherwise = swapMUntil s cond (n+1, m>>= swapM s) 
                         where c = length (filter cond m) /= 0 {- si m es vacía entonces no se puede llegar
                                                                 a la matrix destino con esta permutación
                                                                 en particular -}

answer :: Int
answer = fst (swapMUntil 4 (== targetMatrix) (0,[sourceMatrix]))


{-------------------------------------------}
{--------------  EJERCICIO 2  --------------}
{-------------------------------------------}
type Disk = Int
data Peg = L | C | R deriving (Eq, Show)
type Conf = ([Disk], [Disk], [Disk]) 
type Move = (Peg,Peg)



-- parte (a)
push :: Disk -> Peg -> State Conf Conf
push d L = state $ \(a,b,c) -> ((a,b,c),(d:a,b,c))
push d C = state $ \(a,b,c) -> ((a,b,c),(a,d:b,c))
push d R = state $ \(a,b,c) -> ((a,b,c),(a,b,d:c))

pop :: Peg -> State Conf Disk
pop L = state $ \(a,b,c) -> (head a, (tail a,b,c))
pop C = state $ \(a,b,c) -> (head b, (a,tail b,c))
pop R = state $ \(a,b,c) -> (head c, (a,b,tail c))


-- parte (b)
step :: Move -> State Conf Conf
step (L,C) = do
  disk <- pop L
  disk2 <- pop C
  if disk < disk2 then 
    push disk2 C >> push disk C
  else step (L,R)
step (L,R) = do
  disk <- pop L
  disk2 <- pop R
  if disk < disk2 then 
    push disk2 R >> push disk R
  else step (L,C)
step (C,R) = do
  disk <- pop C
  disk2 <- pop R
  if disk < disk2 then 
    push disk2 R >> push disk R
  else step (C,L)
step (C,L) = do
  disk <- pop C
  disk2 <- pop L
  if disk < disk2 then 
    push disk2 L >> push disk L
  else step (C,R)
step (R,L) = do
  disk <- pop R
  disk2 <- pop L
  if disk < disk2 then 
    push disk2 L >> push disk L
  else step (R,C)
step (R,C) = do
  disk <- pop R
  disk2 <- pop C
  if disk < disk2 then 
    push disk2 C >> push disk C
  else step (L,C)
step (L,L) = state $ \c -> (c,c)
step (C,C) = state $ \c -> (c,c)
step (R,R) = state $ \c -> (c,c)

{-
-- parte (c)
optStrategy :: Int -> Move -> State Conf [(Move,Conf)]
optStrategy 0 _     = state $ \x -> ([],x)
optStrategy n (L,C) = 
-}

-- parte (d)
{-
La primera implementación implementaba una imitación naïve de generación de estados, esto
lo hace de manera tediosa y propensa a propagación de errores. La Mónada de Estado es una abstracción
del proceso de cambios de estado donde ya se implementan muchas de las utilidades y aplicaciones que
por otro lado se debiesen implementar manualmente, dando poca oportunidad de modificación del código. Así
usar mónada de estados para obtener la estrategia óptima es más legible, menos tediosa y de modificación fácil.

-}


-- parte (e)
play :: Int -> Peg -> Peg -> IO()
play n p1 p2 = undefined




{-------------------------------------------}
{--------------  EJERCICIO 3  --------------}
{-------------------------------------------}
type Probability = Rational
type Dist a = T Probability a


-- Parte (a.I)
pointDist :: Int -> Dist (Int, Int)
pointDist r = do
  x <- uniform [-r..r]
  y <- uniform [-r..r]
  return (x,y)


-- Parte (a.II)
resultE3a :: Int -> Probability
resultE3a r = 4 * pCircle 
  -- Filtra puntos cuyo modulo sea menor al radio r de circunferencia y entrega probabilidad de caer en círculo
  --                |                              |
  --                v                              v
  where pCircle = (==True) ?? (fmap (\(x,y)-> (x * x + y * y < r * r)) (pointDist r)) 

-- Parte (b)

data Uni     = Chile | Cato deriving (Eq,Ord,Show)
type Urn     = (Int, Int)
-- 1er componente: #jugadores Chile, 2do componente: #jugadores Cato


pickPlayer :: Urn -> Dist (Uni, Urn)
pickPlayer (uch,uc) = choose p (Chile, (uch-1,uc)) (Cato,(uch,uc-1)) where
        p = (uchRat / (uchRat + ucRat))
        uchRat = toRational uch
        ucRat = toRational uc


aux :: Int -> Urn -> Dist [(Uni,Urn)]
aux 0 _ = pure []
aux n (x,y) = (:) <$> pickPlayer (x,y) <*> aux (n-1) (x,y-1)

resample :: Urn -> Dist (Uni, Urn)
resample (x,y) = pickPlayer (x,y) >>= f where
  f (Chile,(a,b)) = return (Chile,(a-1,b))
  f (Cato,(a,b))  = pickPlayer (a-1,b)


resultE3b :: Probability
resultE3b = undefined
-- complete la definicion


main :: IO ()
main = return ()