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