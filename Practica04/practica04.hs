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
alcance f = error "Sin implementar."

--2. -bv. Función que devuelve las variables ligadas de una fórmula.
-- bv (All "x" (Ex "y" (Pr "P" [V "x", V "y", V "z"])))
bv :: Form -> [Nombre]
bv f = error "Sin implementar."

--3. -fv. Función que devuelve las variables libres de una fórmula.
-- fv (Ex "y" (Pr "P" [V "x", V "z"]))
fv :: Form -> [Nombre]
fv f = error "Sin implementar."

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