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