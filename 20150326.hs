{-Trabalho 3-}

{-Questao 1-}

type Table = [(Int, Int)] -- Primeiro int = chave, segundo int = valor

{-getElem :: Table -> Int -> Int
getElem [] _ = 0 -- ???
getElem ((a, as):bs) n
 | a == n = as
 | otherwise = getElem bs n-}

getElem :: Table -> Int -> [Int]
getElem [] _ = []
getElem ((a, as):bs) n
 | a == n = [as]
 | otherwise = getElem bs n

hasKey :: Table -> Int -> Bool
hasKey [] _ = False
hasKey ((a, as):bs) n
 | a == n = True
 | otherwise = hasKey bs n

putElem :: Table -> (Int, Int) -> Table
putElem as (x, y) 
 | hasKey as x = as -- Nao adiciona se ja existir a chave
 | otherwise = (as ++ [(x,y)])

removeElem :: Table -> Int -> Table -- int = chave
removeElem [] _ = []
removeElem xs x = [(a, as) | (a, as) <- xs, (a /= x)]

{-Questao 2-}

contemElem :: (Eq t) => [t] -> t -> Bool
contemElem [] _ = False
contemElem (a:as) b
 | a == b = True
 | otherwise = contemElem as b 

contem :: (Eq t) => [t] -> [t] -> Bool
contem [] _ = True -- o segundo conj contem todos os elems do primeiro
contem (a:as) b
 | contemElem b a = contem as b -- se o segundo conj contem aquele elemento, passa pro proximo
 | otherwise = False

intersec :: (Eq t) => [t] -> [t] -> Bool -- o primeiro conj contem algum elemento do segundo?
intersec _ [] = False
intersec (a:as) (b:bs)
 | contemElem (a:as) b = True
 | otherwise = intersec (a:as) bs

comparaConjuntos :: (Eq t) => [t] -> [t] -> String
comparaConjuntos a b
 | (contem a b) && (contem b a) = "A igual a B"
 | contem b a = "A contem B"
 | contem a b = "B contem A"
 | intersec a b = "A interseciona B"
 | otherwise = "Conjuntos disjuntos"
 
 -----------------------------------------------
 
 {-Exercicios em sala-}
 
take' :: [t] -> Int -> [t]
take' [] _ = []
take' (a:as) 0 = []
take' (a:as) n = a:(take' as (n-1))
 
drop' :: [t] -> Int -> [t]
drop' [] _ = []
drop' (a:as) 1 = as
drop' (a:as) n = drop' as (n-1)

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' f (b:bs)
 | f (head bs) = b:(takeWhile' f bs)
 | otherwise = [b]
 
{-outro modo
takeWhile :: (t-> Bool) -> [t] -> [t]
takeWhile _ [] = []
takeWhile f (a:as)
 | f a = a:takeWhile f as
 | otherwise = []
-}
 
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' f (b:bs)
 | f (head bs) = dropWhile' f bs
 | otherwise = bs
 
 {-Defina uma funcao polimorfica...-}
{-
length' :: Num t => [t] -> t 
length' [] = 0
length' (a:as) = (length' as) + 1

esquerda :: [t] -> Int -> [t]
esquerda (a:as) 1 = [a]
esquerda (a:as) n = a:(esquerda as (n-1))

direita :: [t] -> Int -> [t]
direita (a:as) 1 = as
direita (a:as) n = direita as (n-1)

merge :: Ord t => [t] -> [t] -> [t]
merge [] a = a
merge a [] = a
merge (a:as) (b:bs)
 | a <= b = a : merge as (b:bs)
 | otherwise = b : merge (a:as) bs

mergeSort :: [t] -> [t]
mergeSort [] = []
mergeSort (a:[]) = [a]
mergeSort as = merge (mergeSort (esquerda as ((length' as) `div` 2))) (mergeSort (direita as ((length' as) `div` 2)))
-}