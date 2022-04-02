{--
--
--
--}
module Practica3 where

import Practica02



{----- Formas Normales -----}

-- 1. fnn. Función que devuelve la Forma Normal Negativa de una 
--         proposición.
fnn :: Prop -> Prop
fnn p = deMorgan(elimEquiv(elimImpl p))

-- 2. fnc. Función que devuelve la Forma Normal Conjuntiva de una 
--         proposición.
fnc :: Prop -> Prop
fnc p = auxFNC (fnn p)

-- Función auxiliar a la función fnc que Distribuye de manera que queden conjunciones de disyunciones.
-- Nota: se obvia que la proposición que recibe como parámetro esta en FNN.
auxFNC :: Prop -> Prop
auxFNC (POr (PAnd x y) z) = auxFNC (PAnd (POr (auxFNC x) (auxFNC z)) (POr (auxFNC y) (auxFNC z)))
auxFNC (POr f (PAnd x y)) = auxFNC (PAnd (POr (auxFNC f) (auxFNC x)) (POr (auxFNC f) (auxFNC y)))
auxFNC (PAnd f g)           = PAnd (auxFNC f) (auxFNC g)
auxFNC (POr f g) | hayConj (POr f g) = auxFNC (POr (auxFNC f) (auxFNC g))
                 | otherwise         = POr (auxFNC f) (auxFNC g)
auxFNC f = f

-- Función auxiliar a auxFNC que nos dice si hay conjunciones en la proposición que recibe como parámetro.
hayConj:: Prop -> Bool
hayConj (PAnd x y) = True
hayConj (POr x y)  = (hayConj x) || (hayConj y)
hayConj _          = False



{----- Algoritmo DPLL -----}

-- Definiciones de algunos conceptos.
type Literal = Prop
type Clausula = [Literal]
type Formula = [Clausula]
type Modelo = [Literal]
type Solucion = (Modelo, Formula)


-- 3. unit. Función que aplica la regla unitaria.
unit :: Solucion -> Solucion
unit (m, []) = (m, [])
--unit (m, (y:ys):xs) = if ys == [] then (m ++ [y], elimina (y:ys) xs) else (a, [y:ys] ++ b) where (a,b) = unit (m, xs)
unit (m, (y:ys):xs)
  | ys == [] = (m ++ [y], elimina (y:ys) xs)
  | otherwise  = (a, [y:ys] ++ b) where (a,b) = unit (m, xs)

-- Función auxiliar elimina - elimina el elemento recibido de la lista recibida
elimina :: Eq a => a -> [a] -> [a]
elimina x [] = []
elimina x (y:ys) | x == y    = elimina x ys
                 | otherwise = y : elimina x ys

-- 4. elim. Función que aplica la regla de eliminación. 
elim :: Solucion -> Solucion
elim (m, f)
  | m == []   = ([], f)
  | otherwise = (m, elimPropRep [clausula | clausula<-f, length[literal | literal<-m, (elem literal clausula)]==0])

-- Función auxiliar a "elim" que conserva el estado de una lista como si fuese un conjunto con orden, esto es
-- no queremos proposiciones repetidas en nuestra lista.
elimPropRep :: Eq a => [a] -> [a]
elimPropRep [] = []
elimPropRep (x:xs) = if elem x xs
  then elimPropRep xs
  else x : elimPropRep xs


-- 5. red. Función que aplica la regla de reducción.
red :: Solucion -> Solucion
red (m, f)
  | m == [] = ([],f)
  | otherwise = (m, (elimPropRep [ (elimVar literal clausula) | clausula<-f, literal<-m,(elem (neg(literal)) clausula)]) ++ (dif f [clausula | clausula<-f, literal<-m,(elem (neg(literal)) clausula)]))
--([],f) = ([],f)
--red (m, f) 

-- Función que elimina la literal en la clausula. Auxiliar de "red".
elimVar :: Literal -> Clausula -> Clausula
elimVar p q = if elem (neg p) q then (dif q [(neg p)]) else q

-- Función que niega la variable (si ya está negada, se aplica regla de Doble Negación) dada.
-- Auxiliar de "red".
neg :: Prop -> Prop
neg (PVar p) = (PNeg (PVar p))
neg (PNeg  (PVar p)) = PVar p

-- Función que devuelve una lista con la diferencia entre dos listas. Auxiliar de "red".
dif :: Eq a => [a] -> [a] -> [a]
dif x y
  | x == [] && y == [] = []
  | y == []            = []
  | x == []            = []
dif (x:xs) (y:ys) = if elem x (y:ys)
  then dif xs (y:ys)
  else [x] ++ dif xs (y:ys)

-- 6. split. Función que aplica la regla de la partición de una literal.
--            Se debe tomar la primer literal que aparezca en la fórmula.
split :: Solucion -> [Solucion]
split (m, f) = error "Sin implementar."

-- 7. conflict. Función que determina si la Solucion llegó a una contradicción.
conflict :: Solucion -> Bool
conflict (m, f) = error "Sin implementar."

-- 8. success. Función que determina si la fórmula es satisfacible.
success :: Solucion -> Bool
success (m, f) = error "Sin implementar."

--9. appDPLL. Función que aplica las reglas anteriores una vez.
appDPLL :: Solucion -> Solucion
appDPLL (m, f) = error "Sin implementar."



{-- Puntos Extra --}

{--
--dpll. Función que aplica el algoritmo DPLL a una fórmula.
dpll :: Solucion -> Solucion
dpll (m, f) = error "Sin implementar."
--}
