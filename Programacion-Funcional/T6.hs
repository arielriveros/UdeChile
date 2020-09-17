{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

import Test.Hspec
import Test.QuickCheck
import Test.Hspec.Core.QuickCheck(modifyMaxSize)
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
type Valuation = Assoc Char Bool

{-
Tests
g1 = Imply (Var 'A') (And (Var 'A') (Var 'B'))  -- False
g2 = Imply (And (Var 'A') (Imply (Var 'A') (Var 'B'))) (Var 'B') -- True
g3 = Imply (Var 'A') (Var 'A')  -- True
g4 = (((Var 'A') `Imply` ((Var 'A' `And` Var 'B'))) `Imply` (Var 'B' `And` (Var 'B'))) -- False
g5 = (((Var 'B') `Imply` (Var 'A')) `Imply` ((((Var 'A') `And` (Var 'B')) `Imply` (Var 'A')))) -- True
g6 = Imply (And (Var 'A') (Var 'B')) (Var 'C')  -- False
-}

-- Parte (a)

foldF :: (Variable -> b) -> (b -> b) -> (b -> b -> b) -> (b -> b -> b) -> (Bool -> b) -> Formula -> b
foldF _ _ _ _ constF (Const b)                    = constF b
foldF varF _ _ _ _ (Var v)                        = varF v
foldF varF notF andF implyF constF (Not f)        = notF $ foldF varF notF andF implyF constF f
foldF varF notF andF implyF constF (And f1 f2)    = andF (foldF varF notF andF implyF constF f1) (foldF varF notF andF implyF constF f2)
foldF varF notF andF implyF constF (Imply f1 f2)  = implyF (foldF varF notF andF implyF constF f1) (foldF varF notF andF implyF constF f2)

-- Agregue tipo y definicion

-- Parte (b)

eval :: Formula -> Valuation -> Bool
eval formula valuation = foldF (\x -> fromRight True $ find x valuation) (not) (&&) (<=) (id) formula

fvar :: Formula -> [Char]
fvar formula  = foldF (\x -> x:[]) (id) (\x y -> x ++ y) (\x y -> x ++ y) (\_ -> []) formula

isTaut :: Formula -> Maybe Valuation
isTaut f | and [ eval f v | v <- allVals f ] = Nothing
         | otherwise = Just $ fromRight [(' ',True)] $ find False [(eval f v, v)| v <- allVals f ]

rmdups :: Eq a => [a] -> [a]
rmdups [] = []
-- here I can also do x: filter (/= x) (rmdups xs)
rmdups (x:xs) = x : rmdups (filter (/= x) xs)

bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n = map (False :) r ++ map (True :) r where
  r = bools (n-1)

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

-- hint

push :: Disk -> Peg -> Conf -> Conf
push d p conf1 | null (conf1 p) = conf2 | d < head (conf1 p) = conf2 | otherwise = error "Illegal move"
  where
   conf2 L | p == L = d : conf1 L | otherwise = conf1 L
   conf2 C | p == C = d : conf1 C | otherwise = conf1 C
   conf2 R | p == R = d : conf1 R | otherwise = conf1 R

pop :: Peg -> Conf -> (Disk, Conf)
pop p conf1 | null (conf1 p) = error ("Trying to move from empty peg") | otherwise = (head (conf1 p), conf2)
 where
  conf2 L | p == L = tail (conf1 L) | otherwise = conf1 L
  conf2 C | p == C = tail (conf1 C) | otherwise = conf1 C
  conf2 R | p == R = tail (conf1 R) | otherwise = conf1 R

-- Parte (a)
step :: Move -> Conf -> Conf
step (source, destination) conf = 
  let aux = pop source conf
    in push (fst aux) destination (snd aux)
  
-- Parte (b)

optStrategy :: Int -> Move -> Conf -> [(Move, Conf)]
optStrategy 1 move conf     = [(move, step move conf)]
optStrategy disks move conf = let
                              source = fst move
                              destination = snd move 

                              move1 = optStrategy (disks - 1) (source, aux) conf
                              move2 = [(move, step move (snd $ last move1))]
                              move3 = optStrategy (disks - 1) (aux, destination) $ snd $ last move2

                              aux | source == L || destination == L = 
                                 if source == C || destination == C 
                                  then R 
                                  else C
                                  | otherwise = L

                                in move1 ++ move2 ++ move3

makeInit :: Int -> Peg -> Conf
makeInit n p p' | p' == p   = [1..n]
                | otherwise = []

play :: Int -> Peg -> Peg -> IO()
play n s t = putStr $ show initConf ++ foldr f v (optStrategy n (s,t) initConf) where
  initConf  = makeInit n s
  v         = []
  f (m,c) r = "\n -> " ++ show m ++ " -> " ++ show c ++ r

-- Parte (c)
others :: Peg -> (Peg,Peg)
others L = (R,C)
others C = (L,R)
others R = (L,C)

instance {-# OVERLAPPING #-} Arbitrary Move where
  arbitrary = do
    s <- frequency [(1,return L), (1,return C), (1,return L)]
    t <- let (x1,x2) = others s in frequency [(1,return x1), (1,return x2)]
    return (s,t)

testValid :: [(Move, Conf)] -> Bool
testValid [] = True
testValid (x:xs) = let conf = snd x
                       isValid [] = True
                       isValid [x] = True
                       isValid (x:xs) = x < head xs && isValid xs
                       in isValid (conf L) && isValid (conf C) && isValid (conf R) && testValid xs

testoptStrategy :: Spec
testoptStrategy =
  describe "Optimal strategy for Hanoi Tower:" $ modifyMaxSize (const 10) $ do
    it "Configuraciones generadas son validas" $
        property $ \n (s, t) -> 1 <= n ==> testValid (optStrategy n (s, t) (makeInit n s))
    it "Tamaño de la estrategia optima" $
        property $ \n (s, t) -> 1 <= n ==> length (optStrategy n (s, t) (makeInit n s)) == 2^n - 1

{-------------------------------------------}
{--------------  EJERCICIO 4  --------------}
{-------------------------------------------}

data Nat = Zero | Succ Nat deriving (Eq, Ord, Show)

add :: Nat -> Nat -> Nat
add Zero     m = m
add (Succ n) m = Succ (add n m)

mult :: Nat -> Nat -> Nat
mult Zero     _ = Zero
mult (Succ n) m = add m (mult n m)

foldNat :: (b -> b) -> b -> Nat -> b
foldNat _ v Zero     = v
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
foldBT _ g (Leaf v)         = g v
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
sizeBT = foldBT (\r1 _ r2 -> r1 + 1 + r2) (const 1)

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

main :: IO()
main = hspec testoptStrategy