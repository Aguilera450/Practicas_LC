{--
Este es el ejercio 3 
--}

import Data.List(sortBy)
import Data.Ord(comparing)


qsort :: (Ord a) => [a] -> [a]
qsort [] = []
qsort (x : xs) =
  qsort [a | a <- xs, a < x]
    ++ [x]
    ++ qsort [b | b <- xs, b >= x]


-- Función principal
-- Recibe una lista 
-- Devuelve un entero
-- Implementa 5 funciones auxiliares

prodReps :: [Int] -> Int
prodReps (x:xs) = (multiplicaElementos(getUltimo(tsort(tuplas(qsort(x:xs))))))

-- 2da función auxiliar
-- Recibe la lista ordenada de qsort(1ra función)
-- Devuelve una lista de listas de la cantidad
--  de veces que se repite el número
tuplas :: [Int] -> [[Int]]
tuplas [] = []
tuplas (x:xs) = let a = takeWhile (==x) xs  
                    b = dropWhile (==x) xs
                 in (x : a) : tuplas b

-- 3ra función auxiliar
-- Recie una tupla y la ordena de modo que la lista más
--  larga queda al final, es decir de número que más se 
--  repitio su lista queda al fial.
-- Devuelve una tupla ordenada
tsort :: [[a]] -> [[a]]
tsort = sortBy (comparing length)

-- 4ta función auxiliar
-- Recibe una tupla ordenada
-- Devuelve la ultima lista de la tupla
getUltimo :: [[a]] -> [a]
getUltimo [x] = x
getUltimo (_:xs) = getUltimo xs

-- 5ta función auxiliar
-- Recibe una lista 
-- Devuelve la multiplicación de los elementos 
--  de la lista
multiplicaElementos :: [Int] -> Int
multiplicaElementos (x:xs)
   | length (x:xs) == 1 = x * 1
   | otherwise = x * multiplicaElementos xs

main :: IO ()
main = do
  print (tuplas [2,3,3,3,4,5,52,75]) -- Ya esta ordenada
  print (tsort [[2],[3,3,3],[4,4],[5],[52],[75]]) 
  print (getUltimo [[2],[5],[52],[75],[4,4],[3,3,3]])
  print (multiplicaElementos [3,3,3])
  print (prodReps [2,3,3,3,4,5,52,75])
