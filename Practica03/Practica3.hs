{--
-- Equipo: InvadirPolonia.
-- Integrantes:
-- *) Marco Silva Huerta: 316205326.
-- *) Adrián Aguilera Moreno: 421005200.
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
-- Se hace concatenación de las dos ramas que hace la función split.
split :: Solucion -> [Solucion]
split (x, y) = varPositiva(x,y) ++ varNegativa(x,y)

-- Función que genera la formula positiva al aplicar la regla split
varPositiva :: Solucion -> [Solucion]
varPositiva (x,y) = [(x ++ listaLiterales y ,y)]

-- Función que genera la formula negativa al aplicar la regla split
varNegativa :: Solucion -> [Solucion]
varNegativa (x,y)=[(x ++ [negarVar(cabeza (listaLiterales y))], y)]

-- Función auxiliar para aplicar deMorgan a una variable
negarVar :: Literal -> Literal
negarVar p = deMorgan(PNeg p)

-- Funcion auxliar para tener la lista en una lista de litereales de la formula
-- Recibe: una lista de clausulas (literales)
-- Devuelve: La lista de las literales
listaLiterales :: [Clausula] -> [Literal]
listaLiterales (x:xs) = sacaPrimero x

--Funcion auxiliar que busca y saca al primero de una formula
sacaPrimero :: Clausula -> [Literal]
sacaPrimero (x:xs)
  | (uniVariable x) == True = [x]
  | otherwise = [convierte(extraeVar x)]

-- Función auxuliar para asegurarnos que es una unica variable
-- Recibe: Prop
-- Devuelve: True o False, de acuerdo a su longitud.
-- Usamos función vars de Practica 02
uniVariable :: Prop -> Bool
uniVariable p
    | length (vars p) == 1 || length (vars p) == 0 = True
    | otherwise = False

-- Función auxiliar para sacar la variable cabeza de una proposicion
-- Recibe: Prop
-- Devuelve: String con la cabeza que es la variable de la Prop
-- Usamos función vars de Practica 02
extraeVar :: Prop-> String
extraeVar p = cabeza (vars p)

-- Función auxiliar que convierte un string a un variable
convierte :: String -> Literal
convierte p = PVar p

-- Función auxiliar para obtener la cabeza
cabeza :: [a] -> a
cabeza (x:_) = x

-- FIN DEL 6 ------------------------------------------------------------------------

-- 7. conflict. Función que determina si la Solucion llegó a una contradicción.
conflict :: Solucion -> Bool
conflict (m, f)
  | f == [[]]           = False
  | m == [] && f == []  = False
--  | f == []             = False
  | m == []             = False
conflict ([p], f) = if notElem [neg p] f
  then False
  else True
conflict ((x:xs), f) = if conflict([x], f)
  then True
  else conflict(xs, f)

-- 8. success. Función que determina si la fórmula es satisfacible.
success :: Solucion -> Bool
success (m, f) =  f == [] && m /= []

--9. appDPLL. Función que aplica las reglas anteriores una vez.
appDPLL :: Solucion -> Solucion
appDPLL (m, f) = red(elim(unit(m, f)))

{-- Puntos Extra --}

{--
--dpll. Función que aplica el algoritmo DPLL a una fórmula.
dpll :: Solucion -> Solucion
dpll (m, f) = error "Sin implementar."
--}
