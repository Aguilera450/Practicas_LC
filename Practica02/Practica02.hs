{--
-- Equipo: InvadirPolonia.
-- Integrantes:
-- *) Marco Silva Huerta: 316205326.
-- *) Adrián Aguilera Moreno: 421005200.
--}

module Practica2 where

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
  show (PNeg x) = "~" ++ (show x) 
  show (POr x y) = "(" ++ (show x) ++ " ∨ " ++ (show y) ++ ")"
  show (PAnd x y) = "(" ++ (show x) ++ " ∧ " ++ (show y) ++ ")"
  show (PImpl x y) = "(" ++ (show x) ++ " → " ++ (show y) ++ ")"
  show (PEquiv x y) = "(" ++ (show x) ++ " ↔ " ++ (show y) ++ ")"


--1. interp. Función que evalua una proposición dado el estado.
interp :: Estado -> Prop -> Bool  
interp e (PVar x) = elem x e
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
modelos f  = [i | i <- (estados f),
              interp i f]

--6. tautologia. Función que dice si una proposición es tautología.
tautologia :: Prop -> Bool
tautologia p = (estados p) == (modelos p)

--7. satisfen. Función que resuelve si una proposición es satisfacible
-- 				con cierto estado.
satisfen :: Estado -> Prop -> Bool
satisfen e p = error "Sin implementar."

--8. satisf. Función que resuelve si una proposición es satisfacible.
satisf :: Prop -> Bool
satisf p
  | (modelos p) /= [] = True
  | otherwise = False

--9. insatisfen. Función que resuelve si una proposición es insatisfacible
-- 					con cierto estado.
insatisfen :: Estado -> Prop -> Bool
insatisfen e p = error "Sin implementar."

--10. contrad. Función que dice si una proposición es una contradicción.
contrad :: Prop -> Bool
contrad p = error "Sin implementar."

--11. equiv. Función que devuelve True si dos proposiciones son equivalentes.
equiv :: Prop -> Prop -> Bool
equiv p1 p2 = error "Sin implementar."

--12. elimEquiv. Función que elimina las equivalencias lógicas.
elimEquiv :: Prop -> Prop
elimEquiv p = error "Sin implementar."

--13. elimImpl. Función que elimina las implicaciones lógicas.
elimImpl :: Prop -> Prop
elimImpl p = error "Sin implementar."

--14. deMorgan. Función que aplica las leyes de DeMorgan a una proposición.
deMorgan :: Prop -> Prop
deMorgan p = error "Sin implementar."


{-- Punto extra. Funciones que implementan la satisfacibilidad sobre conjuntos.
--               Deben descomentar el siguiente código.--}

{--
estadosConj :: [Prop] -> [Estado]
modelosConj :: [Prop] -> [Estado]
satisfenConj:: Estado -> [Prop] -> Bool
satisfConj:: [Prop] -> Bool
insatisfenConj:: Estado -> [Prop] -> Bool
insatisfConj:: [Prop] -> Bool

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
