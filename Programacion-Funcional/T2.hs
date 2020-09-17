{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-
import Test.Hspec
import Test.QuickCheck
import Test.Hspec.Core.QuickCheck(modifyMaxSize)
-}
import Data.Either



{-------------------------------------------}
{--------------  EJERCICIO 1  --------------}
{-------------------------------------------}

type Assoc k v = [(k,v)] 
type Error     = String

-- Parte (a)

find :: (Eq k, Show k, Eq v) => k -> Assoc k v -> Either Error v 
find key dictionary = case length(dictionary' key) of
                      1     -> Right (head (dictionary' key))
                      0     -> Left ("Key "++show key++" not Found")
                      _     -> Left ("Multiple values for key "++show key)
                      where dictionary' key'' = [value' | (key',value') <- dictionary,key'==key'']

-- Parte (b)
{-
Dado que find compara llaves k buscadas y sus valores v asociados
la función tiene que saber que los tipos pasados como argumentos tienen que tener
un método que permita igualar sus valores con otros.

 k tiene que igualarse con un k' buscado así su tipo debe comportarse como un tipo de la clase Eq

 Además k debe poder ser representado en pantalla por lo que su tipo 
debe también comportarse como tipo de clase Show

 La clase de tipo v en esta implementación en específico es trivial ya que el problema busca encontrar
errores específicos asociados a las llaves, no a los valores. Si find no encuentra ningún error significa
que por definición de find que el valor v asociado a una llave es único por lo tanto v no necesita 
ser comparado con otro valor.
-}



{-------------------------------------------}
{--------------  EJERCICIO 2  --------------}
{-------------------------------------------}

type Variable  = Char
data Formula   = Const Bool
               | Var Variable
               | Not Formula
               | And Formula Formula
               | Imply Formula Formula
               deriving Show
type Valuation = Assoc Char Bool

-- Parte (a)

-- foldF :: ... -> (Formula -> Valuation)
-- foldF Const c = 


-- Parte (b)
--eval :: Formula -> Valuation -> Bool
eval :: Formula -> Valuation -> Bool
eval (Const b) v     = b
eval (Var x) v       = fromRight True (find x v)
eval (Not f) v       = not (eval f v)
eval (And f1 f2) v   = eval f1 v && eval f2 v
eval (Imply f1 f2) v = eval f1 v <= eval f2 v

-- fvar :: Formula -> [Char]
-- Descomente el tipo y agregue su definiciÃ³n
fvar :: Formula -> [Char]
fvar (Const b)     = []
fvar (Var x)       = [x]
fvar (Not f)       = fvar f
fvar (And f1 f2)   = fvar f1 ++ fvar f2
fvar (Imply f1 f2) = fvar f1 ++ fvar f2

-- Parte (c)
-- isTaut :: Formula -> Maybe Valuation
-- Descomente el tipo y agregue su definiciÃ³n
isTaut :: Formula -> Maybe Valuation
isTaut f = case check of
           True -> Nothing
           where check = (and [ eval f v | v <- allVals f ])

rmdups :: Eq a => [a] -> [a]
rmdups [] = []
-- here I can also do x: filter (/= x) (rmdups xs)
rmdups (x:xs) = x : rmdups (filter (/= x) xs)

bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n = map (False :) r ++ map (True :) r where
  r = bools (n-1)

-- Cuando haya implementado fvar, puede descomentar allVals

allVals :: Formula -> [Valuation]
allVals f = map (zip vars) vals where
  vars = rmdups (fvar f)
  vals = bools (length vars)




{-------------------------------------------}
{--------------  EJERCICIO 3  --------------}
{-------------------------------------------}

data Peg = L | C | R deriving (Eq, Show)
type Disk = Int
type Conf = Peg -> [Disk]
type Move = (Peg,Peg)

instance Show Conf where
  show c = show (c L, c C, c R)


-- Parte (a)

-- hint

push :: Disk -> Peg -> Conf -> Conf
push d L c = L d:c
push d C c = C d:c
push d R c = R d:c

-- step :: Move -> Conf -> Conf
-- Descomente el tipo y agregue su definiciÃ³n


-- Parte (b)
-- optStrategy :: Int -> Move -> Conf -> [(Move,Conf)]
-- Descomente el tipo y agregue su definiciÃ³n

-- Una vez que haya implementado optStrategy
-- puede descomentar las siguientes dos funciones
{-
makeInit :: Int -> Peg -> Conf
makeInit n p p' | p' == p   = [1..n]
                | otherwise = []

play :: Int -> Peg -> Peg -> IO()
play n s t = putStr $ show initConf ++ foldr f v (optStrategy n (s,t) initConf) where
  initConf  = makeInit n s
  v         = []
  f (m,c) r = "\n -> " ++ show m ++ " -> " ++ show c ++ r
-}


-- Parte (c)
others :: Peg -> (Peg,Peg)
others L = (R,C)
others C = (L,R)
others R = (L,C)
{-
instance {-# OVERLAPPING #-} Arbitrary Move where
  arbitrary = do
    s <- frequency [(1,return L), (1,return C), (1,return L)]
    t <- let (x1,x2) = others s in frequency [(1,return x1), (1,return x2)]
    return (s,t)

testoptStrategy :: Spec
testoptStrategy = describe "Optimal strategy for Hanoi Tower:" $ modifyMaxSize (const 10) $ do
  it "Configuraciones generadas son validas" $
                                  -- reemplace lo que sigue a ==> por su codigo
    property $ \n (s,t) -> 1 <= n ==> (n::Int) == n && ((s,t)::Move) == (s,t)
  it "TamaÃ±o de la estrategia optima" $
                                  -- reemplace lo que sigue a ==> por su codigo
    property $ \n (s,t) -> 1 <= n ==> (n::Int) == n && ((s,t)::Move) == (s,t)

-}
{-------------------------------------------}
{--------------  EJERCICIO 4  --------------}
{-------------------------------------------}
data Nat = Zero | Succ Nat deriving (Eq, Ord, Show)

add :: Nat -> Nat -> Nat
add Zero     m = m
add (Succ n) m = Succ (add n m)

mult :: Nat -> Nat -> Nat
mult Zero     m = Zero
mult (Succ n) m = add m (mult n m)

foldNat :: (b -> b) -> b -> Nat -> b
foldNat f v Zero     = v
foldNat f v (Succ n) = f (foldNat f v n)


auxSqr:: Nat -> (Nat, Nat)
auxSqr = foldNat f v where
  v          = (Zero, Zero) -- Caso base 0^2 = 0 = Zero
  f (n, fn)  = (Succ n, add (mult (Succ n) (Succ n)) fn) -- Caso recursivo (n+1, ( (n+1) * (n+1) ) + (n*n))

sumsqrt :: Nat -> Nat
sumsqrt = snd . auxSqr


{-------------------------------------------}
{--------------  EJERCICIO 5  --------------}
{-------------------------------------------}
data BinTree a = Leaf a | InNode (BinTree a) a (BinTree a)

foldBT :: (b -> a -> b -> b) -> (a -> b) -> (BinTree a -> b)
foldBT f g (Leaf v)         = g v
foldBT f g (InNode t1 v t2) = f (foldBT f g t1) v (foldBT f g t2)

-- Parte (a)
{-
***
caso base: La propiedad aplica para una hoja v, para todo v::a
caso inductivo: La propiedad aplica para el arbol constituido por sub arboles que aplican la propiedad

h (g v)       = g' v
h (f t1 v t2) = f' (h t1) v (h t2)

Hipotesis Inductiva := 
                        h.foldBT f g = foldBT f' g'
***

Caso Base:

LHS:
h.foldBT f g (Leaf v)
h (foldBT f g (Leaf v))
h (g v)
g' v

RHS:
foldBT f' g' (Leaf v)
g' v

Así LHS = RHS => caso base si aplica 

Caso Inductivo

LHS:
h.foldBT f g (InNode t1 v t2)
h (foldBT f g (InNode t1 v t2))
h (f (foldBT f g t1) v (foldBT f g t2))
f' (h (foldBT f g t1)) v (h (foldBT f g t2))
{I.H x2}
f' (foldBT f' g' t1) v (foldBT f' g' t2)

RHS:
foldBT f' g' (InNode t1 v t2)
f' (foldBT f' g' t1) v (foldBT f' g' t2)

Así LHS = RHS => Caso inductivo aplica



-}

-- Parte (b)

flattenBT :: BinTree a -> [a]
flattenBT = foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[])

sizeBT :: BinTree a -> Int
sizeBT = foldBT (\r1 v r2 -> r1 + 1 + r2) (const 1)

{-
Resultado de a) 
1) h (g v)       = g' v
2) h (f t1 v t2) = f' (h t1) v (h t2)

=>

h.foldBT f g = foldBT f' g' 

Sean las siguientes funciones "sinónimo":
f :: b -> a -> b -> b -> b
f = (\r1 v r2 -> r1 ++ [v] ++ r2)

g :: a -> b
g = (:[])

f' :: Int -> a -> Int
f' = (\r1 v r2 -> r1 + 1 + r2)

g' :: a -> Int
g' = (const 1)

h :: b -> Int
h = length

Así: flattenBT = foldBT f g
        sizeBT = foldBT f' g'

1) 
h (g v) = g' v
length (foldBT _ (:[]) (Leaf v)) = (const 1) (Leaf v)
length ((:[]) v)                 = const 1 v
length [v]                       = 1
      1                          = 1

2)

LHS:
h (f t1 v t2)
length ((\r1 v r2 -> r1 ++ [v] ++ r2) t1 v t2)
length (t1 ++ [v] ++ t2)
length (t1) + length [v] + length (t2)
length t1 +      1       + length t2

RHS:
f' (h t1) v (h t2)
(\r1 v r2 -> r1 + 1 + r2) (length t1) v (length t2)
(length t1) + 1 + (length t2)
length t1 + 1 length t2

Así LHS = RHS
por lo tanto las funciones sinónimo son consistentes con las propiedades pedidas

es decir

Sí h (g v) = g' v
  y 
   h (f t1 v t2) = f ' (h t1) v (h t2)
   = > 
  h.foldBT f g = foldBT f' g' 

Por lo tanto 
length.foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) = (\r1 v r2 -> r1 + 1 + r2) (const 1) (length t1) v (length t2)
length.foldBT f g = foldBT f' g'
length.flattenBT = sizeBT


-}



-- Parte (c)
mirrorBT :: BinTree a -> BinTree a
mirrorBT = foldBT (\r1 v r2 -> InNode r2 v r1) Leaf

idBT :: BinTree a -> BinTree a
idBT = foldBT InNode Leaf

{-
Resultado de a) 
1) h (g v)       = g' v
2) h (f t1 v t2) = f' (h t1) v (h t2)

=>

h.foldBT f g = foldBT f' g' 

Demostrar 
mirrorBT.mirrorBT = idBT

Sean las siguientes funciones "Sinónimos"

f = (\r1 v r2 -> InNode r2 v r1)
f' = InNode
g = g' = Leaf
h = mirrorBT

1)
h (g v) = g' v
mirrorBT (Leaf v) = Leaf v
foldBT (\r1 v r2 -> InNode r2 v r1) Leaf (Leaf v) = Leaf v
Leaf v = Leaf v 
2)

LHS:
h (f t1 v t2)
mirrorBT ((\r1 v r2 -> InNode r2 v r1) (InNode t1 v t2))
mirrorBT (InNode t2 v t1)
foldBT (\r1 v r2 -> InNode r2 v r1) Leaf (InNode t2 v t1)
(\r1 v r2 -> InNode r2 v r1) (foldBT (InNode t2 v t1) Leaf t2) v (foldBT (InNode t2 v t1) Leaf t1)
(\r1 v r2 -> InNode r2 v r1) (mirrorBT t2) v (mirrorBT t1)
InNode (mirrorBT t1) v (mirrorBT t2)

RHS:
f' (h t1) v (h t2)
InNode (mirrorBT t1) v (mirrorBT t2)

Así LHS = RHS
por lo tanto, al igual que en b), las funciones sinónimo son consistentes con las propiedades pedidas

mirrorBT.(foldBT (\r1 v r2 -> InNode r2 v r1) Leaf) = foldBT (InNode Leaf)
mirrorBT.mirrorBT = idBT

-}


-- Parte (d)
mapBT :: (a -> b) -> BinTree a -> BinTree b
mapBT f (Leaf v)         = Leaf (f v)
mapBT f (InNode t1 v t2) = InNode (mapBT f t1) (f v) (mapBT f t2)

{-
Probar que map f (flattenBT t) = flattenBT (mapBT f t)

Caso base:
LHS

map f (flattenBT (Leaf v))
map f (foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) (Leaf v))
map f ((:[]) v)
map f [v]
[f v]

RHS

flattenBT (mapBT f (Leaf v))
flattenBT (Leaf (f v))
foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) Leaf(f v)
(:[]) f v 
[f v]

Caso inductivo

*********** flattenBT = foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[])

LHS
map f (flattenBT (InNode t1 v t2))
map f (foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) InNode(t1 v t2))
map f ((\r1 v r2 -> r1 ++ [v] ++ r2) (foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) t1) v foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) t2)
map f ((foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) t1) ++ [v] ++ (foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) t2))
map f (foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) t1) 
      ++ map f [v]
      ++ map f ((foldBT (\r1 v r2 -> r1 ++ [v] ++ r2) (:[]) t2)


RHS
flattenBT (mapBT f (InNode t1 v t2))
flattenBT (InNode (mapBT f t1) (f v) (mapBT f t2))

-}



--main :: IO()
--main = hspec testoptStrategy