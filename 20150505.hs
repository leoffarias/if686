-- TRABALHO 11


--Questao 2
import Control.Monad
import Data.Char

avaliarAux :: Maybe String -> Bool
avaliarAux (Just []) = True
avaliarAux (Just (a:as))
 | (a == ' ') || (isLetter a)  = avaliarAux (Just as)
 | otherwise = False

avaliar :: Maybe String -> Maybe String
avaliar str
 | avaliarAux str = str
 | otherwise = Nothing

maiuscula :: Maybe String -> Maybe String
maiuscula Nothing = Nothing
maiuscula (Just str) = Just [toUpper s | s <- str]

quebraAux :: String -> String -> [String]
quebraAux [] ac = [ac]
quebraAux (a:as) ac
 | a == ' ' = ac:(quebraAux as [])
 | otherwise = (quebraAux as (ac++[a]))

quebra :: Maybe String -> [String]
quebra Nothing = [[]]
quebra (Just str) = quebraAux str []

main :: IO()
main = forever $ do  
    putStr "Digite uma cadeia de caracteres: "  
    str <- getLine
    str2 <- return (avaliar (Just str))
    str3 <- return (maiuscula str2)
    str4 <- return (quebra str3)
    mapM_ putStrLn str4