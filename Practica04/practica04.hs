{--
-- Equipo: InvadirPolonia.
-- Integrantes:
-- *) Marco Silva Huerta: 316205326.
-- *) Adrián Aguilera Moreno: 421005200.
--} 
module Practica4 where

--Definición del tipo de datos para términos.
data Term = V Nombre | F Nombre [Term] deriving (Eq)

--Definición del tipo de datos para fórmulas.
data Form = NForm | TrueF | FalseF | Pr Nombre [Term] | Eq Term Term | 
            Neg Form | Conj Form Form | Disy Form Form | 
            Imp Form Form | Equi Form Form | All Nombre Form | 
            Ex Nombre Form deriving (Eq)

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
fv f = diferencia (varsFormu f) (bv f)

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
-- varsdTermino (V "x")
varsdTermino :: Term -> [Nombre]
varsdTermino (V x) = [x]
varsdTermino(F f []) = []
varsdTermino (F f [x]) = varsdTermino x
varsdTermino (F f (x:xs)) = varsdTermino x ++ varsConjunto xs

-- 3ra Funcion Auxiliar
-- Separamos las variables de un conjunto de terminos.
-- varsConjunto [V "a", F "x" []]
varsConjunto :: [Term] -> [Nombre]
varsConjunto [] = []
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
sustTerm (V var) [] = V var
sustTerm (V var) ((var',t):ts) = if var == var' then t else sustTerm (V var) ts
sustTerm (F f t) sust = F f (sustTermAux t sust)

-- Función auxiliar para la función sustTermAux que realiza la
-- sustitución a un conjunto de términos.
sustTermAux :: [Term] -> Subst -> [Term]
sustTermAux term [] = term
sustTermAux [] sust = []
sustTermAux (x:xs) sust = [sustTerm x sust] ++ (sustTermAux xs sust)


--5. -sustForm. Función que realiza la sustitución de variables en una 
--          fórmula sin renombramientos.
-- sustForm (Ex "x" (Pr "P" [V "x", V "y"])) [("y", F "a" [])]
sustForm :: Form -> Subst -> Form
sustForm f [] = f
sustForm NForm s =  error "No se puede sustituir en una fórmula vacía :("
sustForm TrueF s =  error "No se puede sustituir en constantes lógicas :("
sustForm FalseF s = error "No se puede sustituir en constantes lógicas :("
sustForm (Pr p (t:ts)) s = Pr p (sustTermAux (t:ts) s)
sustForm (Eq t1 t2) s = Eq (sustTerm t1 s) (sustTerm t2 s)
sustForm (Neg f) s = Neg (sustForm f s)
sustForm (Conj f1 f2) s = Conj (sustForm f1 s) (sustForm f2 s)
sustForm (Disy f1 f2) s = Disy (sustForm f1 s) (sustForm f2 s)
sustForm (Imp f1 f2) s = Imp (sustForm f1 s) (sustForm f2 s)
sustForm (Equi f1 f2) s = Equi (sustForm f1 s) (sustForm f2 s)
sustForm (All x f) ((n,t):ts) = if elem n (bv (All x f)) then (sustForm (All x f) ts) else sustForm (All x  (sustForm f [(n,t)])) ts
sustForm (Ex x f) ((n,t):ts) =  if elem n (bv (Ex x f)) then (sustForm (Ex x f) ts) else sustForm (Ex x  (sustForm f [(n,t)])) ts

--6. -alphaEq. Función que dice si dos fórmulas son alpha-equivalentes.
-- alphaEq (Ex "x" (Pr "P" [V "x", V "z"])) (Ex "y" (Pr "P" [V "y", V "z"])) True
-- alphaEq (Ex "y" (Pr "P" [V "w", V "z"])) (Ex "y" (Pr "P" [V "x", V "z"])) False
alphaEq :: Form -> Form -> Bool
alphaEq f1 f2 = (fv f1) == (fv f2) && (formEquiv f1 f2)

-- 1er Función auxiliar. Nos dice si dos fórmulas son equivalentes.
formEquiv :: Form -> Form -> Bool
formEquiv NForm NForm = True
formEquiv NForm g = False
formEquiv TrueF TrueF = True
formEquiv TrueF g = True
formEquiv FalseF FalseF = True
formEquiv FalseF g = False
formEquiv (Pr p1 t1) (Pr p2 t2) = True && (termEqConj t1 t2)
formEquiv (Pr p t) g = False
formEquiv (Eq f1 f2) (Eq g1 g2) =  True && (termEquiv f1 g1) && (termEquiv f2 g2)
formEquiv (Eq f1 f2) g = False
formEquiv (Neg f) (Neg g) = True && (formEquiv f g)
formEquiv (Neg f) g = False
formEquiv (Conj f1 f2) (Conj g1 g2) = True && (formEquiv f1 g1) && (formEquiv f2 g2)
formEquiv (Conj f1 f2) f = False
formEquiv (Disy f1 f2) (Disy g1 g2) = True && (formEquiv f1 g1) && (formEquiv f2 g2)
formEquiv (Disy f1 f2) f = False
formEquiv (Imp f1 f2) (Imp g1 g2) = True && (formEquiv f1 g1) && (formEquiv f2 g2)
formEquiv (Imp f1 f2) f = False
formEquiv (Equi f1 f2) (Equi g1 g2) = True && (formEquiv f1 g1) && (formEquiv f2 g2)
formEquiv (Equi f1 f2) f = False
formEquiv (Ex x f) (Ex y g) = True && (formEquiv f g)
formEquiv (Ex x f) g = False
formEquiv (All x f) (All y g) = True && (formEquiv f g)
formEquiv (All x f) g = False

-- 2da función auxiliar. Nos dice si dos terminos son equivalentes.
termEquiv :: Term -> Term -> Bool
termEquiv (V x) (V y) = True
termEquiv (V x) f = False
termEquiv (F f t) (F f' t') = True && termEqConj t t'
termEquiv (F f t) t' = False

-- 3ra función auxiliar. Nos dice si dos conjuntos (representados por listas) de terminos
-- son equivalentes.
termEqConj :: [Term] -> [Term] -> Bool
termEqConj [] [] = True
termEqConj [] t = False
termEqConj t [] = False
termEqConj [a] [b] = termEquiv a b
termEqConj [a] (y:ys) = (termEquiv a y) && termEqConj [a] ys
termEqConj (x:xs) [b] = (termEquiv x b) && (termEqConj xs [b])
termEqConj (x:xs) (y:ys) = (termEqConj [x] [y]) && (termEqConj [x] ys) && (termEqConj xs [y]) && (termEqConj xs ys)

{-------------------- Puntos Extra --------------------}
-- 1. Función que renombra variables ligadas.
renom :: Form -> Form
renom TrueF  = TrueF
renom FalseF  = FalseF
renom (Pr p t) = (Pr p t)
renom (Eq t t') = (Eq t t')
renom (Neg t)  = Neg (renom t)
renom (Conj t t') = Conj (renom t) (renom t')
renom (Disy t t') = Disy (renom t) (renom t')
renom (Imp t t') = Imp (renom t) (renom t')
renom (Equi t t') = Equi (renom t) (renom t')
renom (All n f) = (All (n++"'") (renom(sustForm f [(n,V (n++"'"))])))
renom (Ex n f) = (Ex (n++"'") (renom(sustForm f [(n,V (n++"'"))])))


-- 2. Renombra las variables ligadas de una fórmula de tal manera en que no se
-- renombren por las variables iniciales en ningún punto.
renomConj :: Form -> Form
renomConj f = renAuxConj f (fv f)

-- Función que renombra la variables ligadas de una fórmula donde sus  nombres son ajenos a los de una lista dada.
renAuxConj :: Form -> [Nombre] -> Form
renAuxConj TrueF l = TrueF
renAuxConj FalseF  l = FalseF
renAuxConj (Pr p s)l  = (Pr p s)
renAuxConj (Eq t t') l = (Eq t t')
renAuxConj (Neg t)  l = Neg (renAuxConj t l)
renAuxConj (Conj t t') l = Conj (renAuxConj t l) (renAuxConj t' l)
renAuxConj (Disy t t') l = Disy (renauxconj t l) (renAuxConj t' l)
renAuxConj (Imp t t') l = Imp (renauxconj t l) (renAuxConj t' l)
renAuxConj (Equi t t') l = Equi (renAuxConj t l) (renAuxConj t' l)
renAuxConj (All n f) l = if(not (elem (n++"'") l ) ) 
                        then (All (n++"'") (renom(sustForm f [(n,V (n++"'"))])))
                        else renAuxConj (All (n++"'") (renom(sustForm f [(n,V (n++"'"))]))) l
renauxconj (Ex n f) l = if(not (elem (n++"'") l ) ) 
                        then (Ex (n++"'") (renom(sustForm f [(n,V (n++"'"))])))
                        else renAuxConj (All (n++"'") (renom(sustForm f [(n,V (n++"'"))]))) l

-- 3. Función que aplica la sustitución a una fórmula alpha-equivalente.
sustFormAlpha :: Form -> Subst -> Form
sustFormAlpha f sust = sustForm(renAuxConj f ((listavarSus sust)++(fv f))) sust

-- Regresa una lista con las variables a sustituir que conforman esa sustitución (e.g. x := y, entonces regresa [x]).
listavarSus::Subst->[Nombre]
listavarSus []        = []
listavarSus [sust]    = [fst sust]                 -- fst devuelve el primer elemento (item) en una tupla.
listavarSus (sust:ss) = fst sust:(listavarSus ss)  -- Aquí también se usa fst.
