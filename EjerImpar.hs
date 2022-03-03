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

-- 5. Elimina. Función que elimina de la lista el número del índice.
elimina :: [Int] -> Int -> [Int]
elimina [] n = []
elimina (x:xs) 0 = xs
elimina (x:xs) n = x : elimina xs (n - 1)


main :: IO ()
main = do
  print (anagrama "amor" "romo")
  print (elimina  [1, 4, 3, 2, 5] 4)
