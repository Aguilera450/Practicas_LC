{--
-- Equipo: InvadirPolonia.
-- Integrantes:
-- *) Marco Silva Huerta.
-- *) Adrián Aguilera Moreno: 421005200.
--}
module Practica1 where

-- 1. Anagrama. Función que decide si dos palabras son un anagrama.
anagrama :: String -> String -> Bool
anagrama s1 s2 = (qsort s1) == (qsort s2)

-- Función auxiliar QuickSort para ordenar las palabras y verifiar si son iguales.
qsort :: (Ord a) => [a] -> [a]
qsort [] = []
qsort (x : xs) =
  qsort [a | a <- xs, a < x]
    ++ [x]
    ++ qsort [b | b <- xs, b >= x]

-- Función auxiliar a segmento.
-- Obtiene una sublista hasta el índice indicado.
subcadenaInd :: Int -> [Int] -> [Int]
subcadenaInd n (x:xs)
  | n < 0         = []
subcadenaInd n [] = []
subcadenaInd n (x:xs) = x : subcadenaInd (n - 1) xs

-- Función auxiliar a segmento.
-- Elimina la sublista hasta el índice indicado.
eliminaHasta :: Int -> [Int] -> [Int]
eliminaHasta n (x:xs)
  | n <= 0             = (x:xs)
  | length (x:xs) == 0 = []
eliminaHasta n (x:xs) = eliminaHasta (n - 1) xs

--2. segmento. Función que devuelve la parte de la lista 
--             comprendida por los índices.
segmento :: Int -> Int -> [Int] -> [Int]
segmento n m list
  | n < 0 || m < 0  = list
  | n > m           = list
segmento n m list   = eliminaHasta n (subcadenaInd m list)

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AQUÍ VA EL 03
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

-- 5. Elimina. Función que elimina de la lista el número del índice.
elimina :: [Int] -> Int -> [Int]
elimina [] n = []
elimina (x:xs) 0 = xs
elimina (x:xs) n = x : elimina xs (n - 1)

--6. Binario. Tipo de dato para representación de binario.
data Binario = U | Cero Binario | Uno Binario

instance Show Binario where
    show U = "1"
    show (Cero b) = show b ++ "0" 
    show (Uno b)  = show b ++ "1"

--a. suma. Función que obtiene el resultado de la suma de dos binarios.
suma :: Binario -> Binario -> Binario
suma U U = (Cero U)
suma U (Cero b) = (Uno b)
suma (Cero b) U = (Uno b)
suma (Uno b) U = (Cero (suma U b))
suma U (Uno b) = (Cero (suma U b))
suma (Uno b1) (Cero b2) = (Uno (suma b1 b2))
suma (Cero b1) (Uno b2) = (Uno (suma b1 b2))
suma (Cero b1) (Cero b2) = (Cero (suma b1 b2))
suma (Uno b1) (Uno b2) = (Cero (suma U (suma b1 b2)))

-- Función auxiliar a la función antecesor.
-- Función que encuentra el complemento a2 del binario.
complementoA2 :: Binario -> Binario
complementoA2 U = U
complementoA2 (Uno U) = U
complementoA2 (Cero U) = (Cero U)
complementoA2 (Uno b) = suma (Cero (complementoA2 b)) U
complementoA2 (Cero b) = suma (Uno (complementoA2 b)) U

--b. antecesor. Función que obtiene el antencesor de un binario.
antecesor :: Binario -> Binario
antecesor b = complementoA2 (suma (complementoA2 b) U)

--OA. Tipo de dato para las operaciones aritméticas binarias. 
data OA = No String | Suma OA OA | Resta OA OA | Producto OA OA 
            | Division OA OA | Modulo OA OA

--7. Definición de la instancia de la clase Show para mostrar las OA.
instance Show OA where
  show (No n) = n
  show (Suma n m)     = "(" ++ (show n) ++ " + " ++ (show m) ++ ")"
  show (Resta n m)    = "(" ++ (show n) ++ " - " ++ (show m) ++ ")"
  show (Modulo n m)   = "(" ++ (show n) ++ " % " ++ (show m) ++ ")"
  show (Division n m) = "(" ++ (show n) ++ " / " ++ (show m) ++ ")"
  show (Producto n m) = "(" ++ (show n) ++ " * " ++ (show m) ++ ")"
