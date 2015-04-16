-- TRABALHO
{-
De acordo com nossas pesquisas, a complexidade dos algoritmos de heapsort e mergesort no geral pode ser representada por (n log n). Porém, como em Haskell trabalhamos com listas, a complexidade aumenta por se ter uma grande necessidade de manipular elementos fazendo releitura das listas (sem termos acesso direito ao elemento) e sem poder armazenar variaveis.
-}

-- mergesort
length' :: [Int] -> Int -- retorna o tamanho da lista
length' [] = 0
length' (a:as) = (length' as) + 1

esquerda :: [Int] -> Int -> [Int] -- retorna os elementos a esquerda de um numero da lista, inclusive o proprio
esquerda (a:as) 1 = [a]
esquerda (a:as) n = a:(esquerda as (n-1))

direita :: [Int] -> Int -> [Int] -- retorna os elementos a direita de um numero da lista, sem incluir o proprio
direita (a:as) 1 = as
direita (a:as) n = direita as (n-1)

merge :: [Int] -> [Int] -> [Int] -- une duas listas, considerando qual o menor elemento dois a dois
merge [] a = a
merge a [] = a
merge (a:as) (b:bs)
 | a <= b = a : merge as (b:bs)
 | otherwise = b : merge (a:as) bs

mergeSort :: [Int] -> [Int] -- quebra a lista em duas e ordena recursivamente
mergeSort [] = []
mergeSort (a:[]) = [a]
mergeSort as = merge (mergeSort (esquerda as ((length' as) `div` 2))) (mergeSort (direita as ((length' as) `div` 2)))

--heapsort
getElement :: Int -> [Int] -> Int -- retorna o numero da lista dada uma posicao, considerando que a primeira posicao = 1
getElement 1 (a:as) = a
getElement position (a:as) = getElement (position - 1) (as)

getPai :: Int -> [Int] -> Int -- retorna o no pai de um numero dada sua posicao
getPai 1 (a:as) = a
getPai position (a:as) = getElement (position `div` 2) (a:as) -- pai = numero de posicao n/2 

createHeap :: Int -> [Int] -> [Int] -- cria o heap dada uma entrada
createHeap position list
    | position == (length' list) + 1 = list
    | getElement position list <=  getPai position list = createHeap (position + 1) list
    | otherwise = createHeap (position `div` 2) (swap (position `div` 2) position list) -- retona a criacao a partir da menor posicao para verificar se precisa de swap novamente

swap :: Int -> Int -> [Int] -> [Int] -- faz a troca entre dois elementos do heap
swap position1 position2 list =  inicio position1 list ++ [getElement position2 list] ++ meio position1 position2 list ++ [getElement position1 list] ++ fim position2 list

inicio :: Int -> [Int] -> [Int] -- auxilia o swap a pegar a lista antes o pai
inicio 1 list = []
inicio position (a:as) = a : inicio (position - 1) as

meio :: Int -> Int -> [Int] -> [Int] -- auxilia o swap a pegar a lista entre pai e filho
meio pai filho (a:as)
    | pai >= 1 = meio (pai - 1) (filho-1) as
    | filho > 1 = a : meio pai (filho-1) as
    | otherwise = []

fim :: Int -> [Int] -> [Int] -- auxilia o swap a pegar a lista depois do filho
fim position (a:as)
    | position > 1 = fim (position - 1) as
    | otherwise = as

sort :: [Int] -> [Int] -- elimina o maior elemento do heap e recria o heap ate a lista estar ordenada
sort [] = []
sort list = heapSort (createHeap 1 (inicio (length' list) (swap 1 (length' list) list))) ++ [getElement 1 list]

heapSort :: [Int] -> [Int] -- metodo heapsort que cria o primeiro heap e depois chama o sort
heapSort [] = []
heapSort list = sort (createHeap 1 list)

----------------------

--EXERCICIOS EM SALA

menorMaior :: Int -> Int -> Int -> (Int, Int)
menorMaior x y z = (a, c)
 where (a, c) = (min (min x y) z, max (max x y) z)
 
{-ordenaTripla :: (Int, Int, Int) -> (Int, Int, Int)
ordenaTripla (x, y, z) = (a, c, b)
 where (a, b) = menorMaior x y z
       c = -}

 {- outro modo:
menorMaior3 :: Int -> Int -> Int -> (Int, Int)
menorMaior3 x y z
 | (x > y) && (x > z) && (y > z) = (z, x)
 | (x > y) && (x > z) = (y, x)
 | (y > x) && (y > z) && (x > z) = (z, y)
 | (y > x) && (y > z) = (x, y)
 | (y > x) = (x, z)
 | otherwise = (y, z)-}
 
menorMaior2 :: Int -> Int -> Int -> (Int, Int, Int)
menorMaior2 x y z
 | (x > y) && (x > z) && (y > z) = (z, y, x)
 | (x > y) && (x > z) = (y, z, x)
 | (y > x) && (y > z) && (x > z) = (z, x, y)
 | (y > x) && (y > z) = (x, z, y)
 | (y > x) = (x, y, z)
 | otherwise = (y, x, z)
 
ordenaTripla2 :: (Int, Int, Int) -> (Int, Int, Int)
ordenaTripla2 (x, y, z) = (a, b, c)
 where (a, b, c) = menorMaior2 x y z
 
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
 
{- Exemplo: biblioteca -}

type Pessoa = String
type Livro = String
type BancoDados = [(Pessoa, Livro)]

baseExemplo :: BancoDados
baseExemplo = [("Sergio","O Senhor dos Aneis"), ("Andre","Duna"), ("Fernando","Jonathan Strange & Mr. Norrell"),  ("Fernando","A Game of Thrones")] -- livros emprestados

livros :: BancoDados -> Pessoa -> [Livro]
livros bd pes = [b | (a,b) <- bd, a == pes]

{-outro modo
livros [] pp = []
livros ((p,l):as) pp
 | pp == p = l:livros as
 | otherwise = livros as
-}

emprestimos :: BancoDados -> Livro -> [Pessoa]
emprestimos bd livro = [a | (a,b) <- bd, b == livro]

emprestado :: BancoDados -> Livro -> Bool
emprestado [] _ = False
emprestado ((p, l):as) livro
 | l == livro = True
 | otherwise = emprestado as livro

qtdEmprestimos :: BancoDados -> Pessoa -> Int
qtdEmprestimos [] _ = 0
qtdEmprestimos ((p, l):as) pessoa
 | pessoa == p = qtdEmprestimos as pessoa + 1
 | otherwise = qtdEmprestimos as pessoa