data Failable t = Valor t | Erro String deriving Show

instance Monad Failable where
 (>>=) (Valor x) f = f x
 (>>=) (Erro x) _ = Erro x
 return x = Valor x

data Fila t = Elem t (Fila t) | Nil

criarFila :: Int -> t -> Failable (t, Fila t)
criarFila n t = Valor (t, (Elem t (Nil)))
