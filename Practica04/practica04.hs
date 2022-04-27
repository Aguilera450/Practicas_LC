{--
-- Equipo: InvadirPolonia.
-- Integrantes:
-- *) Marco Silva Huerta: 316205326.
-- *) Adrián Aguilera Moreno: 421005200.
--} 
module Practica4 where

--Definición del tipo de datos para términos.
data Term = V Nombre | F Nombre [Term]

--Definición del tipo de datos para fórmulas.
data Form = NForm | TrueF | FalseF | Pr Nombre [Term] | Eq Term Term | 
            Neg Form | Conj Form Form | Disy Form Form | 
            Imp Form Form | Equi Form Form | All Nombre Form | 
            Ex Nombre Form

type Nombre = String

type Subst = [(Nombre,Term)]

--Instancia Show para Term.
instance Show Term where
  show (V x) = x
  show (F f t) = f ++ "(" ++ show t ++ ")"

--Instancia Show para Form.
instance Show Form where
  show NForm = ""
  show TrueF = "T"
  show FalseF = "F"
  show (Pr p t) = p ++ "(" ++ show t ++ ")"
  show (Eq t1 t2) = "(" ++ show t1 ++ "=" ++ show t2 ++ ")"
  show (Neg f) = "¬" ++ show f
  show (Conj f1 f2) = "(" ++ show f1 ++ " ^ " ++ show f2 ++ ")"
  show (Disy f1 f2) = "(" ++ show f1 ++ " v " ++ show f2 ++ ")"
  show (Imp f1 f2) = "(" ++ show f1 ++ " -> " ++ show f2 ++ ")"
  show (Equi f1 f2) = "(" ++ show f1 ++ " <--> " ++ show f2 ++ ")"
  show (All x f) = "Alle " ++ x ++ " (" ++ show f ++ ")" 
  show (Ex x f) = "Ein " ++ x ++ " (" ++ show f ++ ")"



--1. -alcance. Función que devuelve el alcance de los cuantificadores de
--          una fórmula.
-- alcance (All "x" (Ex "y" (Pr "P" [V "x", V "y"])))
alcance :: Form -> [(Form, Form)]
alcance NForm = []
alcance TrueF = []
alcance FalseF = []
alcance (Pr p t) = []
alcance (Eq t1 t2) = []
alcance (Neg f) = alcance f
alcance (Conj f1 f2) = []
alcance (Disy f1 f2) = []
alcance (Imp f1 f2) = []
alcance (Equi f1 f2) = []
alcance (Ex x f) = [(Ex x (NForm), f)] ++ alcance f
alcance (All x f) = [(All x (NForm),f)] ++ alcance f

--2. -bv. Función que devuelve las variables ligadas de una fórmula.
-- bv (All "x" (Ex "y" (Pr "P" [V "x", V "y", V "z"])))
bv :: Form -> [Nombre]
bv NForm = []
bv TrueF = []
bv FalseF = []
bv (Pr p t) = []
bv (Eq t1 t2) = []
bv (Neg f) = []
bv (Conj f1 f2) = []
bv (Disy f1 f2) = []
bv (Imp f1 f2) = []
bv (Equi f1 f2) = []
bv (Ex p f) = elimPropRep ([p] ++ bv f)
bv (All p f) = elimPropRep ([p] ++ bv f)

-- Función auxiliar para elimiar repetidos 
-- Esta función esta reciclada de la practica03
elimPropRep :: Eq a => [a] -> [a]
elimPropRep [] = []
elimPropRep (x:xs) = if elem x xs
  then elimPropRep xs
  else x : elimPropRep xs


--3. -fv. Función que devuelve las variables libres de una fórmula.
-- fv (Ex "y" (Pr "P" [V "x", V "z"]))
fv :: Form -> [Nombre]
fv f = diferencia(varsFormu f) (bv f)

-- 1ra Función Auxiliar
-- Buscamos obtener todas las variables de la fórmula
--  Usamos nuevamente elimPropRep 
-- (Ex "x" (Pr "P" [V "x", V "y"]))
varsFormu :: Form -> [Nombre]
varsFormu NForm = []
varsFormu TrueF = []
varsFormu FalseF = []
varsFormu (Pr p f) = varsConjunto f
varsFormu (Eq f1 f2) = varsdTermino f1 ++ varsdTermino f2
varsFormu (Neg f) = elimPropRep(varsFormu f)
varsFormu (Conj f1 f2) = elimPropRep(varsFormu f1 ++ varsFormu f2)
varsFormu (Disy f1 f2) = elimPropRep(varsFormu f1 ++ varsFormu f2)
varsFormu (Imp f1 f2) = elimPropRep(varsFormu f1 ++ varsFormu f2)
varsFormu (Equi f1 f2) = elimPropRep(varsFormu f1 ++ varsFormu f2)
varsFormu (Ex x f) = elimPropRep(varsFormu f)
varsFormu (All x f) = elimPropRep(varsFormu f)

-- 2da Funcion Auxiliar 
-- Separamos las variables de un termino.
-- varsConjunto:  varsTerm (V "x")
varsdTermino :: Term -> [Nombre]
varsdTermino (V x) = [x]
varsdTermino(F f []) = []
varsdTermino (F f [x]) = varsdTermino x
varsdTermino (F f (x:xs)) = varsdTermino x ++ varsConjunto xs


-- 3ra Funcion Auxiliar
-- Separamos las variables de un conjunto de terminos.
-- varsConjunto [V "a", F "x" []]
varsConjunto :: [Term] -> [Nombre]
varsConjunto [x] = varsdTermino x
varsConjunto (x:xs) = varsdTermino x ++ varsConjunto xs

-- 4ta Funcion Auxiliar
-- Regresamos la lista con la diferencia entre las variables 
--  ligas y las libres
diferencia :: Eq a => [a] -> [a] -> [a]
diferencia xs ys = zs
    where zs = [x | x <- xs, x `notElem` ys]


--4. -sustTerm. Función que realiza la sustitución de variables en un término.
-- sustTerm F "f" [V "x", F "a" []] [("x", V "y")]
sustTerm :: Term -> Subst -> Term
sustTerm t s = error "Sin implementar."

--5. -sustForm. Función que realiza la sustitución de variables en una 
--          fórmula sin renombramientos.
-- sustForm (Ex "x" (Pr "P" [V "x", V "y"])) [("y", F "a" [])]
sustForm :: Form -> Subst -> Form
sustForm f s = error "Sin implementar."

--6. -alphaEq. Función que dice si dos fórmulas son alpha-equivalentes.
-- alphaEq (Ex "x" (Pr "P" [V "x", V "z"])) (Ex "y" (Pr "P" [V "y", V "z"])) True
-- alphaEq (Ex "y" (Pr "P" [V "w", V "z"])) (Ex "y" (Pr "P" [V "x", V "z"])) False
alphaEq :: Form -> Form -> Bool
alphaEq f1 f2 = error "Sin implementar."

{-- Puntos Extra
renom :: Form -> Form
renomConj :: Form -> Form
sustFormAlpha :: Form -> Subst -> Form
--}
