data Shape = Circle Float | Rectangle Float Float

area :: Shape -> Float
area (Circle r) = (pi * (r*r)) 

--------------------------

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
 | otherwise = aulaPLC (DiaUtil x y as) 
