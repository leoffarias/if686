-- TRABALHO 9

----- Questao 2 -----

data Grafos = Grafo [(Int, [(Int,Double)])] deriving (Show, Eq) -- grafo representado por vertice e lista de (adjacencente, peso)
-- foi definido na questao que o rotulo seria obrigatoriamente um int, entao fizemos uma modificacao para tirar tambem o Nil que nao seria mais necessario
-- alem disso, foi preciso alterar o valor dos pesos para um Double, para utilizar o algoritmo de djkstra que inicia distancias com um infinito (Double)
-- para um grafo não direcionado assumimos que na entrada se tiver uma adjacencia de numero1 para numero2, havera tambem de numero2 para numero1 
-- para facilitar o algoritmo consideramos uma tabela de (vertice, distancia minima para chegar ate ele, precedente)
-- referencia: http://www.inf.ufsc.br/grafos/temas/custo-minimo/dijkstra.html

g = Grafo ([(0,[(1,10),(2,2)]), (1,[(0,10),(2,4),(3,5)]), (2,[(0,2),(1,4),(4,3)]), (3,[(1,5),(4,2)]), (4,[(2,3),(3,2)])]) -- exemplo

h = Grafo ([(0,[(1,10),(2,2)]), (1,[(0,10),(2,4)]), (2,[(0,2),(1,4),(4,3)]), (3,[]), (4,[(2,3)])]) -- exemplo

infinito = 1/0

formaTabela :: Grafos -> Int -> [(Int, Double, Int)] -- forma a tabela usada no algoritmo colocando a distancia do vertice inicial = 0
formaTabela (Grafo []) _ = []
formaTabela (Grafo ((x,y):as)) inicial
    | x == inicial = (x, 0, x) : (formaTabela (Grafo as) inicial) -- se for o vertice inicial, a distancia sera 0
    | otherwise = (x, infinito, (-1)) : (formaTabela (Grafo as) inicial) -- ao contrario, a principio distancia = infinito e o precedente = -1

defineAbertos :: Grafos -> [Int] -- pega os vertices do grafo para a primeira definicao de quais estao abertps
defineAbertos (Grafo []) = []
defineAbertos (Grafo ((vertice, y):as)) = vertice : (defineAbertos (Grafo (as)))

marcaFechado :: [Int] -> (Int, Double) -> [Int] -- marca um vertice como fechado
marcaFechado abertos (vertice, distanica) = [x | x <- abertos, x /= vertice]

menorDistancia :: [(Int, Double, Int)] -> [Int] -> Double -- retorna a menor distancia existente na tabela entre os vertices abertos
menorDistancia tabela abertos = foldr (min) infinito ([y | (x,y,z) <- tabela, (elem x abertos)])

verticeMenorDistancia :: [(Int, Double, Int)] -> [Int] -> (Int, Double)
verticeMenorDistancia tabela abertos = head ([(x,y) | (x,y,z) <- tabela, y == (menorDistancia tabela abertos)])

adjacentes :: Grafos -> (Int,Double) -> [(Int, Double)] -- retorna a lista de vertices adjacentes e seus pesos usando o grafo como entrada
adjacentes (Grafo []) _ = []
adjacentes (Grafo ((x,y):as)) (vertice,peso)
    | x == vertice = y
    | otherwise = adjacentes (Grafo as) (vertice,peso)

auxTabela :: [(Int, Double, Int)] -> (Int, Double) -> [Int] -> (Int, Double) -> [(Int, Double, Int)] -- altera distancia e precedente caso melhor caminho
auxTabela [] _ _ _ = []
auxTabela ((vertice1, distanciaAtual, precendete):as) (anterior, distancia) abertos (vertice2,peso)
    | (vertice1 == vertice2) && (elem vertice1 abertos) && ((peso + distancia) < distanciaAtual) =  ((vertice1, (peso + distancia), anterior):as)
    | otherwise = (vertice1, distanciaAtual, precendete) : (auxTabela as (anterior, distancia) abertos (vertice2,peso))

alteraTabela :: [(Int, Double, Int)] -> (Int, Double) -> [Int] -> [(Int, Double)] -> [(Int, Double, Int)] -- atualiza os adjacentes usando auxTabela
alteraTabela tabela _ _ [] = tabela
alteraTabela tabela verticeAnterior abertos ((vertice,peso):as)
    | as == [] = auxTabela tabela verticeAnterior abertos (vertice,peso)
    | otherwise = alteraTabela (auxTabela tabela verticeAnterior abertos (vertice,peso)) verticeAnterior abertos as

formaCaminho :: [(Int, Double, Int)] -> [(Int, Double, Int)] -> Int -> Int -> [Int] -- forma o caminho a partir dos precedentes
formaCaminho [] _ _ _ = []
formaCaminho ((vertice, distancia, precedente):as) tabelaOficial inicio posicao
    | posicao == inicio = [posicao]
    | vertice == posicao = (formaCaminho tabelaOficial tabelaOficial inicio precedente) ++ [vertice]
    | otherwise = formaCaminho as tabelaOficial inicio posicao

verificaCaminho :: [Int] -> Int -> Int -> [Int] -- verifica se o caminho formado é válido
verificaCaminho (a:as) inicio fim
    | a == inicio = (a:as)
    | otherwise = [] -- se o primeiro elemento não for o inicio, o caminho não existe

dijkstra :: Grafos -> [(Int, Double, Int)] -> [Int] -> (Int, Double) -> [(Int, Double, Int)] -- algoritmo de dijkstra
dijkstra grafo tabela abertos anterior
	| ((length abertos) == 1) = alteraTabela tabela anterior abertos (adjacentes grafo (verticeMenorDistancia tabela abertos)) 
	| otherwise = dijkstra grafo (alteraTabela tabela anterior abertos (adjacentes grafo (verticeMenorDistancia tabela abertos))) (marcaFechado abertos (verticeMenorDistancia tabela abertos)) (verticeMenorDistancia (alteraTabela tabela anterior abertos (adjacentes grafo (verticeMenorDistancia tabela abertos))) (marcaFechado abertos (verticeMenorDistancia tabela abertos)))
 
geraFuncaoMenorCaminho :: Grafos -> (Int -> Int -> [Int]) -- funcao principal
geraFuncaoMenorCaminho grafo inicio fim = verificaCaminho (formaCaminho (dijkstra grafo (formaTabela grafo inicio) (defineAbertos grafo) (inicio, 0.0)) (dijkstra grafo (formaTabela grafo inicio) (defineAbertos grafo) (inicio, 0.0)) inicio fim) inicio fim


---------------- QUESTAO 1 --------------------

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

fromList :: [t] -> List t
fromList [] = Nil
fromList (a:as) = (Cabeca a (fromList as))

data Tree t = NilT | Node t (Tree t) (Tree t) deriving (Eq, Show)

depth :: Tree t -> Int
depth NilT = 0
depth t = percorre t (-1) -- raiz tem depth 0

percorre :: Tree t -> Int -> Int
percorre NilT n = n
percorre (Node v e d) n = max (percorre e (n+1)) (percorre d (n+1))

--depth (Node 1 (Node 2 (Node 3 NilT NilT) (Node 4 NilT NilT)) (Node 5 NilT (Node 5 (Node 5 (Node 5 (Node 6 NilT NilT) NilT) NilT) NilT)))

bfs :: Eq t => Tree t -> t -> Bool
bfs NilT n = False
bfs (Node v e d) n
 | v == n = True
 | otherwise = (||) (bfs e n) (bfs d n)
 
mapTree :: (t -> u) -> Tree t -> Tree u
mapTree f NilT = NilT
mapTree f (Node v e d) = (Node (f v) (mapTree f e) (mapTree f d))

-- 09-04

--criarArvore
-- criarArvore [8,3,1,6,4,7,10,14,13] inserir

inserir:: Ord t => t -> Tree t -> Tree t
inserir elemento NilT = (Node elemento NilT NilT)
inserir elemento (Node valor esquerda direita) 
    | elemento > valor = (Node valor esquerda (inserir elemento direita)) 
    | elemento < valor = (Node valor (inserir elemento esquerda) direita)

criarArvore :: Ord t => [t] -> (t -> Tree t -> Tree t) -> Tree t
criarArvore lista funcao = foldr funcao NilT (reverse lista) -- o reverse foi utilizado para a raiz ser o primeiro elemento da lista, nao o ultimo


--14-04
-- diff
diff :: (Eq t) => [t] -> [t] -> [t]
diff [] lista2 = []
diff (a:as) lista2 
    | ((filter (== a) lista2) == []) = a : (diff as lista2)
	| otherwise = diff as lista2

mapfilter :: (t -> Bool) -> [[t]] -> [[t]]
mapfilter ffilter [] = []
mapfilter ffilter (a:as) = [y | y <- a, ffilter y] : (mapfilter ffilter as)

-- (mapfilter) (>(2)) [[1,2,3,4],[2,3,4,5],[1,2,3,4]] -- resultado: [[3,4],[3,4,5],[3,4]]

--16-04
uniao :: (Eq t) => (Ord t) => [[t]] -> [t]
uniao listas = removeRepeticao (sort ((foldr (\ x y -> x ++ y) [] listas)))

sort :: (Eq t) => (Ord t) => [t] -> [t]
sort [] = []
sort (a:as) = sort [b | b <- as, b < a] ++ [a] ++ sort [b | b <- as, b >= a]

removeRepeticao :: (Eq t) => [t] -> [t]
removeRepeticao [] = []
removeRepeticao (a:as)
    | (as /= []) && (a == head as) = removeRepeticao as
    | otherwise = a : removeRepeticao as

-- map fold
-- [ f [True, False] | f <- ((mapfold) func [1,2,10])] -- resultado: [6,7,15]
---     (a:as / [])                 (funcao) (lista / valor da lista = acumulador)

mapfold :: (a1 -> a -> a) -> [a] -> [[a1] -> a]
mapfold funcao lista = [(f x) | x <- lista]
	where
		f acumulador [] = acumulador
		f acumulador (a:as) = f (funcao a acumulador) as

func :: Bool -> Int -> Int -- funcao para teste
func True n = n + 10
func _ n = n - 5

-- Aplicacao Parcial

--isomorficas

iso1 = Node 1 (Node 2 (Node 3 NilT NilT) NilT) (Node 4 NilT (Node 5 NilT NilT))
iso2 = Node 3 (Node 2 (Node 5 NilT NilT) NilT) (Node 7 NilT (Node 4 NilT NilT))
iso3 = Node 3 (Node 2 NilT NilT) (Node 7 NilT NilT)

isomorficas :: (Eq t) => Tree t -> (Tree t -> Bool)
isomorficas NilT NilT = True
isomorficas (Node valor1 esquerda1 direita1) (Node valor2 esquerda2 direita2)
    | ((esquerda1 == NilT) && (esquerda2 /= NilT) || (esquerda1 /= NilT) && (esquerda2 == NilT))= False
    | ((direita1 == NilT) && (direita2 /= NilT) || (direita1 /= NilT) && (direita2 == NilT))= False
    | otherwise = (isomorficas esquerda1 esquerda2) && (isomorficas direita1 direita2)

-- lista de pares

listaPares :: [t] -> ([t] -> [(t,t)])
listaPares [] _ = []
listaPares _ [] = []
listaPares (a:as) (b:bs) = (a,b) : listaPares as bs