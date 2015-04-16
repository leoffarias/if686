double :: [Int] -> [Int]
double as
 | as == [] = [] 
 | otherwise = (head as * 2) : (double (tail as))
 
{--}

member :: [Int] -> Int -> Bool
member as n
 | as == [] = False 
 | (head as) == n = True
 | otherwise = member (tail as) n
 
{--}

member2 :: String -> Char -> Bool
member2 as n
 | as == [] = False 
 | (head as) == n = True
 | otherwise = member2 (tail as) n
 
digits :: String -> String
digits as
 | as == [] = []
 | member2 ['0'..'9'] (head as) = (head as) : digits (tail as)
 | otherwise = digits (tail as)
 
{--}
 
sumPairs :: [Int]->[Int]->[Int]
sumPairs as bs
 | as == [] = bs
 | bs == [] = as
 | otherwise = (head as) + (head bs) : sumPairs (tail as) (tail bs)
 
{-Bonus: Problema somar os elementos de uma lista de outro jeito-}
sumList [] = 0
sumList (a:as) = a + sumList as

double2 [] = []
double2 (a:as) = (2*a) : (double2 as)

{-Exemplo casamento de padroes, selecionando uma lista de um so elemento-}
double3 [] = []
double3 (a:[]) = [2*a] --ou (2*a):[]

--Quicksort

qsort :: Ord a => Num a => [a] -> [a]
qsort [] = []
qsort (a:as) = qsort menor ++ [a] ++ qsort maior
    where menor  = [ x | x <- as, x < a ]
          maior = [ x | x <- as, x >= a ]

-- Fibonacci
fib :: Int -> Int
fib n
 | n < 2 = n
 | otherwise = (fib (n-1)) + (fib (n-2))

fibAux :: Int -> Int -> [Int]
fibAux 0 _ = []
fibAux n x 
 | ((mod fibonacci 2) == 0) = fibonacci : fibAux (n-1) (x+1)
 | otherwise = fibAux n (x+1)
 where fibonacci = (fib x)

fibPar :: Int -> [Int]
fibPar n = fibAux n 0

-- ordena a soma

qsortDigits :: [Int] -> [Int]
qsortDigits [] = []
qsortDigits (a:as) = qsortDigits menor ++ [a] ++ qsortDigits maior
    where menor  = [ x | x <- as, sumDigits x < sumDigits a ]
          maior = [ x | x <- as, sumDigits x >= sumDigits a ]

sumDigits :: Int -> Int
sumDigits 0 = 0
sumDigits x = sumDigits (x `div` 10) + (x `mod` 10)

ordenar :: [Int] -> [Int]
ordenar as = qsortDigits as