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

quicksort :: [Int] -> [Int]
quicksort [] = []
quicksort (a:[]) = [a]
quicksort (a:as)
 | a < (head as) = a : quicksort as
 --| a > (head as) = ([(head as)] ++ [a]) : quicksort as