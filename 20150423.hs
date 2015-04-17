-- TRABALHO 9

--19-03
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

--24-03
{-Exercicio: Ponto e reta-}

type Ponto = (Float, Float)
type Reta = (Ponto, Ponto)

xPonto :: Ponto -> Float
xPonto (a, b) = a

yPonto :: Ponto -> Float
yPonto (a,b) = b

vertical :: Reta -> Bool
vertical (a,b)
 | ((xPonto a) == (xPonto b)) = True
 | otherwise = False

pontoY :: Float -> Reta -> Float
pontoY x ((x1, y1), (x2,y2)) = y1 + (((y2-y1) / (x2-x1)) * (x-x1))

-- Emprestar e devolver banco de dados
type Pessoa = String
type Livro = String
type BancoDados = [(Pessoa, Livro)]

baseExemplo :: BancoDados
baseExemplo = [("Sergio","O Senhor dos Aneis"), ("Andre","Duna"), ("Fernando","Jonathan Strange & Mr. Norrell"),  ("Fernando","A Game of Thrones")] -- livros emprestados

emprestar :: BancoDados -> Pessoa -> Livro -> BancoDados
emprestar bd p l = bd ++ [(p, l)]

devolver :: BancoDados -> Pessoa -> Livro -> BancoDados
devolver bd p l = [(a,b) | (a,b) <- bd, (not (a == p && l == b)) ]

-- Exemplo: Processamento de Texto
getWord :: String -> String
getWord [] = []
getWord (a:as)
 | a /= ' ' = a : getWord as
 | otherwise = []

dropWord :: String -> String
dropWord [] = []
dropWord (a:as)
  | a /= ' ' = dropWord as
  | otherwise = (a:as)

dropSpace :: String -> String
dropSpace [] = []
dropSpace (a:as)
 | a == ' ' = dropSpace as
 | otherwise = (a:as)

type Word = String

quebraEspaco :: String -> String
quebraEspaco [] = []
quebraEspaco (a:as)
 | a == ' ' = []
 | otherwise = a : quebraEspaco as

splitWords :: String -> [Word]
splitWords [] = []
splitWords (a:as) 
 | a /= ' ' = (getWord (a:as) : splitWords (dropWord (a:as)))
 | otherwise = splitWords as

 --

type Line = [Word]

getLine' :: Int -> [Word] -> Line
getLine' 1 (a:as) = [a]
getLine' n (a:as) = getLine' (n-1) as

dropLine :: Int -> [Word] -> [Word]
dropLine 1 (a:as) = as
dropLine n (a:as) = a : dropLine (n-1) as

-- 26-03
-- Crie uma função agrupar...
contaNumaLista :: Eq t => Int -> t -> [t] -> Int
contaNumaLista n _ [] = n 
contaNumaLista n x (a:as)
 | x == a = contaNumaLista (n+1) x as
 | otherwise = contaNumaLista n x as

conta :: Eq t => Int -> t -> [[t]] -> Int
conta n x [] = n
conta n x (a:as) = conta (n + (contaNumaLista 0 x a)) x as

retirar :: Eq t => t -> [[t]] -> [[t]]
retirar x [] = []
retirar x ([]:as) = retirar x as
retirar x ((b:bs):as)
 | x == b = retirar x (bs:as)
 | otherwise = [b] : retirar x (bs:as)

agrupar :: Eq t => [[t]] -> [(t, Int)]
agrupar [] = []
agrupar ([]:as) = agrupar as
agrupar ((b:bs):as) = (b, (conta 0 b ((b:bs):as))) : agrupar (retirar b ((b:bs):as))

--07-04
--Defina as seguintes funções

data Expr = Lit Int | Add Expr Expr | Sub Expr Expr

showExpr :: Expr -> String
showExpr (Lit n) = show n
showExpr (Add e1 e2) = (showExpr e1) ++ "+" ++ (showExpr e2)
showExpr (Sub e1 e2) = (showExpr e1) ++ "-" ++ (showExpr e2)

data List t = Nil | Cabeca t (List t) deriving (Show)

toList :: List t -> [t]
toList Nil = []
toList (Cabeca x (y)) = [x] ++ (toList y)
