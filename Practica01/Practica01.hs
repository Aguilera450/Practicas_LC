{--
-- Equipo: InvadirPolonia.
-- Integrantes:
-- *) Marco Silva Huerta.
-- *) Adrián Aguilera Moreno.
--}
module Practica1 where

--1. anagrama. Función que decide si dos palabras son un anagrama.
anagrama :: String -> String -> Bool
anagrama s1 s2 = error "Sin implementar."


--2. segmento. Función que devuelve la parte de la lista 
--             comprendida por los índices.
segmento :: Int -> Int -> [Int] -> [Int]
segmento n m (x:xs)
  | m > length (x:xs) = (x:xs)
  | n > m             = (x:xs)
  | n == m            = take 1 (drop (n) (x:xs))
  | otherwise         = symbol
  where symbol = take (m - n + 1) (drop (n) (x:xs))

--3. prodReps. Función que devuelve el producto del número con más 
--             repeticiones de una lista.
prodReps :: [Int] -> Int
prodReps l = error "Sin implementar."

-- Reversa de una lista, esta función funge de auxiliar a esEspejo (4).
reversa :: String -> String
reversa [] = []
reversa (x:xs) = (reversa xs) ++ [x]

--4. esEspejo. Función que determina si una fecha es espejo.
esEspejo :: String -> Bool
esEspejo s = if (reversa s) == s
  then True
  else False


--5. elimina. Función que elimina de la lista el número del índice.
elimina :: [Int] -> Int -> [Int]
elimina l n = error "Sin implementar."


--6. Binario. Tipo de dato para representación de binario.
data Binario = U | Cero Binario | Uno Binario

instance Show Binario where
    show U = "1"
    show (Cero b) = show b ++ "0" 
    show (Uno b) = show b ++ "1"

--a. suma. Función que obtiene el resultado de la suma de dos binarios.
suma :: Binario -> Binario -> Binario
suma b1 b2 = error "Sin implementar."

--b. antecesor. Función que obtiene el antencesor de un binario.
antecesor b = error "Sin implementar."

--OA. Tipo de dato para las operaciones aritméticas binarias. 
data OA = No | Suma OA OA | Resta OA OA | Producto OA OA 
            | Division OA OA | Modulo OA OA

type No = String          

--7. Definición de la instancia de la clase Show para mostrar las OA.            
--instance Show OA where
