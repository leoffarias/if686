
------------------ exercícios em sala --------------------


data Shape = Circle Float | Rectangle Float Float

area :: Shape -> Float
area (Circle r) = (pi * (r*r)) 
area (Rectangle b h) = (b * h)

--------------------------

data Dia = Domingo | Sabado | Segunda Int [String] | Terca Int [String] | Quarta Int [String] | Quinta Int [String] | Sexta Int [String]

fimSemana :: Dia -> String
fimSemana Domingo = "Fim-de-semana"
fimSemana Sabado = "Fim-de-semana"
fimSemana (Segunda n as) = "Nao e fim-de-semana"
fimSemana (Terca n as) = "Nao e fim-de-semana"
fimSemana (Quarta n as) = "Nao e fim-de-semana"
fimSemana (Quinta n as) = "Nao e fim-de-semana"
fimSemana (Sexta n as) = "Nao e fim-de-semana"

aulaPLC :: Dia -> Bool
aulaPLC Domingo = False
aulaPLC Sabado = False
aulaPLC (Segunda h as) = contido as
aulaPLC (Terca h as) = contido as
aulaPLC (Quarta h as) = contido as
aulaPLC (Quinta h as) = contido as
aulaPLC (Sexta h as) = contido as

contido :: [String] -> Bool
contido [] = False
contido (a:as)
 | a == "PLC" = True
 | otherwise = contido as

{-outro modo
data Dia = Segunda | Terca | Quarta | Quinta | Sexta | Sabado | Domingo

data Dias = DiaUtil Dia Int [String] | DiaFds Dia

fimSemana :: Dias -> String
fimSemana (DiaUtil _ _ _) = "Nao e fim-de-semana"
fimSemana (DiaFds _) = "E fim-de-semana"

aulaPLC :: Dias -> String
aulaPLC (DiaFds _) = "Nao ha aula de PLC neste dia"
aulaPLC (DiaUtil _ _ []) = "Nao ha aula de PLC neste dia"
aulaPLC (DiaUtil x y (a:as))
 | a == "PLC" = "Ha aula de PLC neste dia"
 | otherwise = aulaPLC (DiaUtil x y as)  -}
 
----------------------------
 
data Tree t = NilT | Node t (Tree t) (Tree t) deriving (Eq, Show)

{-Outro modo:
data Tree t = NilT | Node t (Tree t) (Tree t) 

showTree :: Show t => Tree t -> String
showTree NilT = []
showTree (Node no (esquerda) (direita)) = (show no) ++ showTree(esquerda) ++ showTree(direita)

eqTree :: Eq t => Tree t -> Tree t -> Bool
eqTree NilT NilT = True
eqTree NilT _ = False
eqTree _ NilT = False
eqTree (Node no1 (esquerda1) (direita1)) (Node no2 (esquerda2) (direita2))
    | (no1 == no2) = (eqTree esquerda1 esquerda2) && (eqTree direita1 direita2)
-}{-}

comparar :: Tree -> Tree -> Bool
comparar (Node no1 (esquerda1) (direita1)) (Node no2 (esquerda2) (direita2))
 | (no1 == no2) = True
 | otherwise = False-}

-- comparar (Node 3 (NilT) (NilT)) (Node 3 (NilT) (NilT))

-- Tree valor esq dir

---
{-}
data Expr = Lit Int | Add Expr Expr | Sub Expr Expr

showExpr :: Expr -> String-}