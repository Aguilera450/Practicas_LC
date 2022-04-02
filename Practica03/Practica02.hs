{--
-- Equipo: InvadirPolonia.
-- Integrantes:
-- *) Marco Silva Huerta: 316205326.
-- *) Adrián Aguilera Moreno: 421005200.
--}

module Practica02 where
--import qualified Data.Set as S

--Prop. Tipo de datos para proposiciones lógicas.
data Prop = PTrue | PFalse | PVar String | PNeg Prop | POr Prop Prop 
                  | PAnd Prop Prop | PImpl Prop Prop | PEquiv Prop Prop

--Estado. Lista de variables asignadas como verdaderas.
type Estado = [String]

--Instancia Show para Prop.
instance Show Prop where
  show PTrue = "True" 
  show PFalse = "False"
  show (PVar x) = x 
  show (PNeg x) = "¬" ++ (show x) 
  show (POr x y) = "(" ++ (show x) ++ " ∨ " ++ (show y) ++ ")"
  show (PAnd x y) = "(" ++ (show x) ++ " ∧ " ++ (show y) ++ ")"
  show (PImpl x y) = "(" ++ (show x) ++ " → " ++ (show y) ++ ")"
  show (PEquiv x y) = "(" ++ (show x) ++ " ↔ " ++ (show y) ++ ")"


--1. interp. Función que evalua una proposición dado el estado.
interp :: Estado -> Prop -> Bool
interp e (PVar x) = elem x e
interp e (PNeg x) = not (interp e x)
interp e (POr x y) = (interp e x) || (interp e y)
interp e (PAnd x y) = (interp e x) && (interp e y)
interp e (PImpl x y) = interp e (POr(PNeg x) y )
interp e (PEquiv x y) = interp e (PAnd (PImpl x y) (PImpl y x))

--2. estados. Función que devuelve una lista de todas las combinaciones
-- 				posibles de los estados de una proposición.
estados :: Prop -> [Estado]
estados p = subconj(vars p)

--3. vars. Función que obtiene la lista de todas las variables de una proposición.
vars :: Prop -> [String]
vars (PVar f) = [f]
vars (PNeg f) = vars f
vars (PAnd f g) = vars f ++ vars g
vars (POr f g) = vars f ++ vars g
vars (PImpl f g) = vars f ++ vars g
vars (PEquiv f g) = vars f ++ vars g

--4. subconj. Función que devuelve el conjunto potencia de una lista.
subconj :: [a] -> [[a]]
subconj [] = [[]]
subconj (x:xs) = [x:ys | ys <- (subconj xs)] ++ (subconj xs)

--5. modelos. Función que devuelve la lista de todos los modelos posibles
-- 				para una proposición.
modelos :: Prop -> [Estado]
modelos f  = [i | i <- (estados f), interp i f]

--6. tautologia. Función que dice si una proposición es tautología.
tautologia :: Prop -> Bool
tautologia p = (estados p) == (modelos p)

--7. satisfen. Función que resuelve si una proposición es satisfacible
-- 				con cierto estado.
satisfen :: Estado -> Prop -> Bool
satisfen e p = interp e p == True
  
--8. satisf. Función que resuelve si una proposición es satisfacible.
satisf :: Prop -> Bool
satisf p
  | (modelos p) /= [] = True
  | otherwise = False

--9. insatisfen. Función que resuelve si una proposición es insatisfacible
-- 					con cierto estado.
insatisfen :: Estado -> Prop -> Bool
insatisfen e p = not (satisfen e p)

--10. contrad. Función que dice si una proposición es una contradicción.
contrad :: Prop -> Bool
contrad p = not (satisf p)

--11. equiv. Función que devuelve True si dos proposiciones son equivalentes.
equiv :: Prop -> Prop -> Bool
equiv p1 p2 = (estados p1) == (estados p2)

--12. elimEquiv. Función que elimina las equivalencias lógicas.
elimEquiv :: Prop -> Prop
elimEquiv (PVar x) = (PVar x)
elimEquiv (PNeg x) = (PNeg (elimEquiv x))
elimEquiv (POr x y) = (POr (elimEquiv x) (elimEquiv y))
elimEquiv (PAnd x y) = (PAnd (elimEquiv x) (elimEquiv y))
elimEquiv (PImpl x y) = (PImpl (elimEquiv x) (elimEquiv y))
elimEquiv (PEquiv x y) = (PAnd (PImpl (elimEquiv x) (elimEquiv y)) (PImpl (elimEquiv y) (elimEquiv x)))
  
--13. elimImpl. Función que elimina las implicaciones lógicas.
elimImpl :: Prop -> Prop
elimImpl (PVar x) = (PVar x)
elimImpl (PNeg x) = (PNeg (elimImpl x))
elimImpl (POr x y) = (POr (elimImpl x) (elimImpl y))
elimImpl (PAnd x y) = (PAnd (elimImpl x) (elimImpl y))
elimImpl (PImpl x y) = (POr (PNeg (elimImpl x)) (elimImpl y))
elimImpl (PEquiv x y) = (PEquiv (elimImpl x) (elimImpl y))

--14. deMorgan. Función que aplica las leyes de DeMorgan a una proposición.
deMorgan :: Prop -> Prop
deMorgan (PVar x)   = (PVar x)
deMorgan (PNeg x)   = morganAux x
deMorgan (PAnd x y) = (PAnd (deMorgan x) (deMorgan y))
deMorgan (POr x y)  = (POr (deMorgan x) (deMorgan y))

-- Auxiliar de la función deMorgan.
morganAux :: Prop -> Prop
morganAux (PVar x)   = PNeg (PVar x)
morganAux (PNeg x)   = deMorgan x 
morganAux (PAnd x y) = POr (morganAux x) (morganAux y) 
morganAux (POr x y)  = PAnd (morganAux x) (morganAux y) 


{-- Punto extra. Funciones que implementan la satisfacibilidad sobre conjuntos.
--               Deben descomentar el siguiente código.--}

-- Función auxiliar a la función estadosConj, que realiza la unión de
-- conjuntos [implementados por listas].
unionConj :: [[a]] -> [a]
unionConj [] = []
unionConj (x:xs) = x ++ (unionConj xs)

-- Función auxiliar a la función estadosConj, que funge como la función
-- vars pero en conjuntos de proposiciones.
varsConj :: [Prop] -> [String]
varsConj p = unionConj [(vars list) | list <- p]

-- 15.
estadosConj :: [Prop] -> [Estado]
estadosConj p = subconj(varsConj p)

-- 16.
modelosConj :: [Prop] -> [Estado]
modelosConj p = error "No implementada."

-- 17.
satisfenConj:: Estado -> [Prop] -> Bool
satisfenConj e p = error "No implementada."
{--
-- 18.
satisfConj:: [Prop] -> Bool
satisfConj p = error "No implementada."

-- 19.
insatisfenConj:: Estado -> [Prop] -> Bool
insatisfenConj e p = error "No implementada."

-- 20.
insatisfConj:: [Prop] -> Bool
insatisfConj p = error "No implementada."

--consecuencia. Función que determina si una proposición es consecuencia
--				del conjunto de premisas.
consecuencia: [Prop] -> Prop -> Bool
consecuencia gamma phi = null [i | i <- estadosConj (phi : gamma),
                               satisfenConj i gamma,
                               not (satisfen i phi)]

--argCorrecto. Función que determina si un argumento es lógicamente
--				correcto dadas las premisas.
argCorrecto :: [Prop] -> Prop -> Bool
argCorrecto gamma psi = consecuencia gamma psi
--}
