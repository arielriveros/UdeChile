import Test.Hspec
import Test.QuickCheck

-- SCORE = 6.2


{-------------------------------------------}
{--------------  EJERCICIO 1  --------------}
{-------------------------------------------}

effPow :: Num a => a -> Int -> a
effPow b n  | n == 0                = 1
            | mod n 2 == 0 && n>0   = g b n 
            | mod n 2 == 1 && n>0   = b * (g b n)
            | otherwise             = error "exponente negativo"
            where 
                g x y = effPow x (div y 2) * effPow x (div y 2)

pay :: Int -> (Int, Int)
pay n | n < 8       = error ("no se pueden pagar " ++ show n++" pesos")
      | n == 8      = (1, 1)
      | n == 9      = (3, 0)
      | n == 10     = (0, 2)
      | otherwise   = (fst(f n)+1, snd(f n))
      where f x = pay (x-3)

{-------------------------------------------}
{--------------  EJERCICIO 2  --------------}
{-------------------------------------------}

numberOfHits :: (a -> Bool) -> [a] -> Int
numberOfHits _ [] = 0
numberOfHits p xs 
                | p (head xs)   = 1 + numberOfHits p (tail xs)
                | otherwise     = numberOfHits p (tail xs)

splitAtFirstHit :: Num a => (a -> Bool) -> [a] -> ([a], [a])
splitAtFirstHit _ []   =  ([],[])
splitAtFirstHit p (x:xs)| p x                                     = ([], x:xs)
                        | not (p x) && not(null (snd(g p xs)))    = (x:(fst(g p xs)), snd(g p xs) ) 
--                                    ^  Agregué esta condición solo para evitar problemas con el print del error
--                                    ejemplo (1,3,***Exception
                        | otherwise                               = error "no hit in the list"
                        where g a b = splitAtFirstHit a b         

positionAllHits :: Num a => (a -> Bool) -> [a] -> [Int]
positionAllHits _ [] = []
positionAllHits p (x:xs) =  aux p (x:xs) 0
      where aux _ [] _ = []
            aux q (y:ys) c | q y          = c:(aux q ys (c+1))
                           | otherwise    = aux q ys (c+1)

evens :: [a] -> [a]
evens [] = []
evens xs = (head xs):(odds (tail xs))

odds :: [a] -> [a]
odds [] = []
odds xs = evens (tail xs)

{-------------------------------------------}
{--------------  EJERCICIO 3  --------------}
{-------------------------------------------}

hasSomeHit :: Eq a => (a -> Bool) -> [a] -> Bool
hasSomeHit _ [] = False
hasSomeHit p (x:xs) | p x           = True
                    | not (p x)     = hasSomeHit p xs
                    | otherwise     = False

isMember :: Eq a => a -> [a] -> Bool
isMember e xs = hasSomeHit (e ==) xs

repeatedElem :: Eq a => [a] -> Bool
repeatedElem [] = False
repeatedElem (x:xs) | hasSomeHit (x ==) xs = True
                    | otherwise            = repeatedElem xs

applyUntil :: (a->a) -> (a -> Bool) -> a -> a
applyUntil f p x | p x        = x
                 | otherwise  = applyUntil f p (f x)

leastPow2 :: Int -> Int
leastPow2 n | n>=0      = applyUntil (2*) (n <= ) 2 
            | otherwise = error ("argumento negativo")

balancedSuffix :: [Bool] -> [Bool]
balancedSuffix [] = []
balancedSuffix xs | s xs            = xs
                  | otherwise       = applyUntil (tail) s (tail xs)
                  where
                        f _ [] = 0
                        f a ys = fromEnum(a == (head ys)) + f a (tail ys)
                        s t= (f True t) == (f False t)

{-------------------------------------------}
{--------------  EJERCICIO 4  --------------}
{-------------------------------------------}

{-
isMemberPF e xs = hasSomeHit (e ==) xs
isMemberPF e xs = hasSomeHit ((==) e) xs
isMemberPF e xs = ((hasSomeHit.(==)) e) xs
isMemberPF e xs = (hasSomeHit.(==)) e xs
-}

isMemberPF :: Eq a => a -> [a] -> Bool
isMemberPF = (hasSomeHit).(==)

{-------------------------------------------}
{--------------  EJERCICIO 5  --------------}
{-------------------------------------------}

testEffPow :: Spec
testEffPow = describe "Test effPow " $ do
      it "a, b, n :Int n>=0 => effPow (a*b) n = effPow a n * effPow b n" $
            property $ \a b n-> (n::Int) >=0 ==>
                  effPow ((a::Int)*(b::Int)) n == (effPow a n)* (effPow b n)
      it "effPow a (m+n) = effPow a m * effPow a n" $
            property $ \a m n -> (m::Int) >= 0 && (n::Int) >= 0 ==>
                  effPow (a::Int) (m + n) == (effPow a m) * (effPow a n)

testPay :: Spec
testPay = describe "Test pay " $ do
      it "n :Int n>=8 => 3a + 5b = n, (a, b) := pay n" $
            property $ \n -> (n::Int)>=8 ==> 3*fst(pay n) + 5*snd(pay n) == n

testNumberOfHits :: Spec
testNumberOfHits = describe "Test numberOfHits " $do
      it "xs, ys :[Int] numberOfHits even (xs ++ ys) = numberOfHits even xs + numberOfHits even ys" $do
            property $ \xs ys -> 
                  numberOfHits even ((xs::[Int]) ++ (ys::[Int])) == numberOfHits even xs + numberOfHits even ys
      it "xs: [Int] numberOfHits true xs = |xs|" $do
            property $ \xs ->
                  numberOfHits (< maxBound) (xs::[Int]) == length(xs)
      it "xs: [Int] numberOfHits false xs = 0" $do
            property $ \xs ->
                  numberOfHits (> maxBound) (xs::[Int]) == 0

testExtraNumberOfHits :: Spec
testExtraNumberOfHits = describe "Test numberOfHits Extra" $do
      it "|AUB|=|A|+|B|-|A inter B|" $do
            property $ \xs ys ->
                  numberOfHits (True ||) ( (xs::[Bool]) ++ (ys::[Bool]) ) == numberOfHits (True ||) xs
                        + numberOfHits (True ||) ys - numberOfHits (False &&) (xs ++ ys)


-----------------------------------------------------------

main :: IO()
main = hspec $ do
  testEffPow
  testPay
  testNumberOfHits
  testExtraNumberOfHits
