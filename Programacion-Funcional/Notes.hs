{-
Ariel Riveros Reffer
Universidad de Chile
Departamento de Ciencias de la Computación
Programación Funcional CC5115 2020
-}


import System.IO()
import Data.List()

{- **Data types**

Represented ::[<Data Type>]
Int = Integer from -2^63 to 2^63
Integer = Unbound Integer (Big as the memory allows it)
Float = Single precision decimal number
Double = Double precision decimal number
Bool = True or False
Char = Characters '<character>'
List = sequence of homogeneous elements [same, data, type]
String = list of characters "<string>"
Tuple = List containing many data types (many, data, types)
-}

-- **Basic Functions**
sumFunction::Int
sumFunction  = sum[1..1000] -- sum of all elements

prodFunction::Int
prodFunction = product[1..10] -- product of all elements

arithmetic::Float
arithmetic = (2 + 3 -1 *3 / 1) **2  -- basic arithmetic

prefixMod::Int
prefixMod = mod 5 4 -- 5mod4

infixMod::Int
infixMod = 5 `mod` 4

boolean::Bool
boolean = not(not(True || False) && False) -- boolean algebra

{- **Functions over lists**

-Build from start to finish
    a1:a2:a3:...:an:[]
-Build from last to first, can merge 2 lists
    xs1 ++ xs2  
-Get the length of a list
    length xs
-Reverse a list
    reverse xs
--Get the Nth element
    xs !! N (starts from position 0)
--Get head or tail (init deletes last element)
    head xs
    tail xs
    init xs
--Max and Min
    maximum xs
    minimum xs
--Make a list from the N first elements from another list_a 
    take N xs
    drop N xs   (N last elements)
--Split a list into 2 smaller lists at Nth position
    splitAt N xs
--Select elements from a list that meet certain condition
    filter condition xs
--Apply a function to all elements from a list
    map function xs

-}
list_a::[Int]
list_a = 1:2:3:4:[] --[1,2,3,4]

list_b::[Int]
list_b = [1, 2]   -- [1,2]

list_c::[Int]
list_c = list_a ++ [5] -- [1,2,3,4,5]

list_d::[[Int]]
list_d = list_a:list_b:[]   -- [[1,2,3,4],[1,2]]

list_e::[Float]
list_e = [1.0..10.0] -- [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0]

list_f::[Bool]
list_f = [True, False, True]

l1::Int
l1 = length list_a              -- 4

l2::Int
l2 = length list_c              -- 2 (l2 is a list of 2 lists!)

l3::[Int]
l3 = reverse list_a             -- [4,3,2,1]

l4::Float
l4 = list_e !! 5                -- 6.0

l5::[Int]
l5 = head list_a : tail list_a  -- tail function returns a list

l6::Float
l6 = maximum list_e             -- 10.0

l7::([Float],[Float])
l7 = splitAt 4 list_e           -- ([1.0,2.0,3.0,4.0],[5.0,6.0,7.0,8.0,9.0,10.0])

l8::[Float]
l8 = filter (<4) list_e         -- [1.0,2.0,3.0]

l9::[Bool]
l9 = map (not) list_f           -- [False,True,False]

-- **Functions**

{-
Regular functions = Lamda calculus

f(x) =          f x
f(x,y) =        f x y
f(g(x)) =       f g x
f(x, g(x)) =    f x (g x)

<name_function> :: inputType1 -> InputType2 -> ... -> outputType

Polymorphic functions

<name_function> :: [a] -> ...
                    ^
                 Takes ANY data type

Guarded equations

<name_function> :: Type1 -> Type2
name_function var | conditional1(var) = output1
                  | conditional2(var) = output2
                  ---
                  | otherwise         = output

-}

{-
Testing

i.e 

-- effPow a b _= a**b

effPow :: Num a => a -> Int -> a
effPow b n  | n == 0                = 1
            | mod n 2 == 0 && n>0   = g b n 
            | mod n 2 == 1 && n>0   = b * (g b n)
            | otherwise             = error "exponente negativo"
            where 
                g x y = effPow x (div y 2) * effPow x (div y 2)

testEffPow :: Spec
testEffPow = describe "Test effPow " $ do
      it "a, b, n :Int n>=0 => effPow (a*b) n = effPow a n * effPow b n" $
            property $ \a b n-> (n::Int) >=0 ==>
                  effPow ((a::Int)*(b::Int)) n == (effPow a n)* (effPow b n)
      it "effPow a (m+n) = effPow a m * effPow a n" $
            property $ \a m n -> (m::Int) >= 0 && (n::Int) >= 0 ==>
                  effPow (a::Int) (m + n) == (effPow a m) * (effPow a n)

-}

{-
** Folding **

Using Recursion:

funcList :: type_f [a] -> abs
funcList f _ = base_case
funcList function xs = function x : function xs

Folding

funcList :: type_f -> [a] -> a
funcList xs = foldr function (base_case) xs
-}



{-
** Data Types **

Synonyms :

type DataTypeName = OtherType

i.e.
type Point = (Float, Float)

move :: Point -> Float -> Point
move (x, y) a = (x+a, y+a)

CAN'T DEFINE RECURSIVE TYPES
i.e type A = (A,int) ===> ERROR

-}

type MyType = Int


--i.e. Use:

--Dictionary:

type Assoc k v = [(k,v)]
find :: Eq k => k -> Assoc k v -> v
find key table = head [ v' | (k',v')<-table, k'==key] -- list comprehension

--New Data Types :

data NewDataTypeName = ValueConstructor1 | ValueConstructor2 
                                                        --   ^ | ... | ValueConstructorN
-- i.e.

data Direction = North | South | West | East

rev :: Direction -> Direction
rev North = South
rev South = North
rev West = East
rev East = West

type Position = (Float, Float)
shift :: Direction -> Position -> Position
shift North (x,y) = (x,y+1)
shift South (x,y) = (x,y-1)
shift West (x,y)  = (x-1,y)
shift East (x,y)  = (x+1,y)

{-

Bool as defined in Prelude:

data Bool = True | False
neg:: Bool -> Bool
neg True  = False
neg False = True
-}
type Distance = Float

data Shape = Circle Position Distance 
           | Rectangle Position Position

type Area = Float

area :: Shape -> Area
area (Circle _ r)                = pi * r ^ (2::Int)
area (Rectangle (x1,y1) (x2,y2)) = abs (x2-x1) * abs (y2-y1)


-- DATA AND TYPE NAMES MUST START WITH UPPERCASE
{-

Types for Partial Functions:

data Maybe a = Nothing | Just a
i.e. division by 0
-}

safeDiv:: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv n d = Just (div n d)

{- Adding deriving Show in definition of a Data type allows that
Data type to print in console

i.e.
data Ex = a | b deriving Show
-}

-- **Recursive Data Types**

data Nat = Zero | Succ Nat deriving Show

natToInt :: Nat -> Int
natToInt Zero = 0
natToInt (Succ n) = (natToInt n) + 1

addNat::Nat -> Nat -> Nat
addNat Zero n = n
addNat (Succ s) n = Succ (addNat s n)

fib::Nat -> Nat 
fib Zero             = Zero
fib (Succ Zero)      = Succ Zero
fib (Succ (Succ n))  = addNat (fib (Succ n)) (fib n)

leq::Nat -> Nat -> Bool
leq Zero _            = True
leq (Succ _) Zero     = False
leq (Succ n) (Succ m) = leq n m

minus:: Nat -> Nat -> Maybe Nat
minus n Zero     = Just n
minus Zero (Succ _)     = Nothing
minus (Succ m) (Succ n) = minus m n

-- Trees

data BinTree a = Leaf a | Node (BinTree a) a (BinTree a)

tree1 :: BinTree Int
tree1 = Node (Leaf 1) 2 (Leaf 3)

{-
        2
       / \
      1   3
-}

tree2 :: BinTree Double
tree2 = Node ( Node (Leaf 4.0) 5.0 (Node (Leaf 1.0) 2.0 (Leaf 3.0))) 6.0 (Leaf 7.0)

{-
                6.0
               /   \
             5.0   7.0
            /   \
          4.0   2.0
               /  \
             1.0  3.0
-}

-- Recursive Data Type Example: Tautology

type Variable  = Char
data Formula   = Const Bool
               | Var Variable
               | Not Formula
               | And Formula Formula
               | Imply Formula Formula
type Valuation = Assoc Char Bool

{-

** Folding over Recursive Data Types **

fold replaces data constructors
example foldr over lists

foldr (+) 0 (1:(2:(3:[]))) ===> (1+(2+(3+0)))

foldX :: (Recursive Case Data Type) -> (Base Case Data Type) -> (Return Data Type)

-}

{-
** Structural Induction **

Is a test mechanism for recursive types

1) Test a base case
    i.e P(0) = []
2) Test recursive case
    i.e P(x) => P(x:xs)

-}

{-
** Evaluation **

Function reduction by substitution:

f a0, a1, ... , an

sqr (2+3)

EVALUATE FOR DEFINITION OF (+)
-> {def +}

sqr (5)

EVALUATE FOR DEFINITION OF sqr
-> {def sqr}

5 * 5

EVALUATE FOR DEFINITION OF (*)
-> {def *}

25

To fully evaluate an expression we apply reduction until it cannot be further reduced

In Haskell expressions can be evaluated in multiple ways

sqr (2+3)
-> {def sqr}
(2+3) * (2+3)
->{def +}
5 * 5
->{def *}
25

Expression that are reductible are called REDEX (REDuctible EXpression)

Sub redex:

mult (2+3, 3+4)

Here 
-mult (2+3, 3+4)
-2+3
-and 3+4
are subredex of mult (2+3, 3+4)

innermost redex of mult (2+3, 3+4)
are 2+3 and 3+4

outermost redex of mult (2+3, 3+4)
is mult (2+3, 3+4)

-}