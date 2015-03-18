fun :: Int -> Int -> Int
fun s n 
	| n == 0 && (vendas n) == s = 1
	| n == 0 = 0
	| (vendas n) == s = fun s (n-1) + 1
	| otherwise = fun s (n-1)

vendas :: Int -> Int
vendas x
	| x == 1 = 1
	| x == 3 = 1
	| otherwise = 0
	

{-outro modo-}
fun2 :: Int -> Int -> Int
fun2 s n
	| n == 0 = if (vendas n) == s then 1 else 0
	| otherwise = if (vendas n) == s then fun2 s (n-1) + 1 else fun2 s (n-1)
