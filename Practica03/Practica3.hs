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
<<<<<<< HEAD
fnn p = deMorgan (elimImpl (elimEquiv p))
=======
fnn p = deMorgan(elimImpl(elimEquiv p))
>>>>>>> origin/main

-- 2. fnc. Función que devuelve la Forma Normal Conjuntiva de una 
--         proposición.
fnc :: Prop -> Prop
fnc p = auxFNC (fnn p)

-- Primera función auxiliar.
auxFNC :: Prop -> Prop
auxFNC (POr (PAnd f1 f2) g) = auxFNC (PAnd (POr (auxFNC f1) (auxFNC g)) (POr (auxFNC f2) (auxFNC g)))
auxFNC (POr f (PAnd g1 g2)) = auxFNC (PAnd (POr (auxFNC f) (auxFNC g1)) (POr (auxFNC f) (auxFNC g2)))
auxFNC (PAnd f g)           = PAnd (auxFNC f) (auxFNC g)
auxFNC (POr f g) | hasConj (POr f g) = auxFNC (POr (auxFNC f) (auxFNC g))
                 | otherwise         = POr (auxFNC f) (auxFNC g)
auxFNC f = f

-- Segunda función auxiliar.
hasConj:: Prop -> Bool
hasConj (PAnd f g) = True
hasConj (POr f g) = (hasConj f) || (hasConj g)
hasConj _          = False



-- Función auxiliar, que define si una fórmula proposicional
-- contiene conjunciones o no.
hayConjuncion :: Prop -> Bool
hayConjuncion (PAnd x y) = True
hayConjuncion (POr x y) = (hayConjuncion x) || (hayConjuncion y)
hayConjuncion _ = False

-- Auxiliar de la Forma Normal Conjuntiva.
auxFNC :: Prop -> Prop
auxFNC (PAnd (POr f1 f2) g) = auxFNC
   (PAnd (POr (auxFNC f1) (auxFNC g)) (POr (auxFNC f2) ( auxFNC g)))
auxFNC (POr f (PAnd g1 g2)) = auxFNC
   (PAnd (POr (auxFNC f) (auxFNC g1)) (POr ( auxFNC f) ( auxFNC g2)))
auxFNC (PAnd f g) = (PAnd (auxFNC f) (auxFNC g) (POr f g))
   | hayConjuncion (POr f g) =  auxFNC (Por (auxFNC f) (auxFNC g))
   | otherwise = (POr (auxFNC f) (auxFNC g))
auxFNC f = f


{----- Algoritmo DPLL -----}

-- Definiciones de algunos conceptos.
type Literal = Prop
type Clausula = [Literal]
type Formula = [Clausula]
type Modelo = [Literal]
type Solucion = (Modelo, Formula)


-- 3. unit. Función que aplica la regla unitaria.
unit :: Solucion -> Solucion
unit (m, f) = error "Sin implementar."

-- 4. elim. Función que aplica la regla de eliminación. 
elim :: Solucion -> Solucion
elim (m, f) = error "Sin implementar."

-- 5. red. Función que aplica la regla de reducción.
red :: Solucion -> Solucion
red (m, f) = error "Sin implementar."

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
