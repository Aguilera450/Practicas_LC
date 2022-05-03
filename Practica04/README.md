# Práctica 04
## Contexto:
<div class=text-justify>
Al momento de implementar la lógica de predicados y la aplicación de la sustitución, es importante considerar varios factores para que la expresividad, y por tanto, la semántica no se vea afectada. Para esto, definimos la lógica de predicados como sigue:

<pre><code>
	data Term = V Nombre | F Nombre [Term]
</code></pre>

<pre><code>
	data Form = TrueF | FalseF | Pr Nombre [Term] | Eq Term Term | Neg Form | Conj Form Form |
	Disy Form Form | Imp Form Form | Equi Form Form | All Nombre Form | Ex Nombre Form
</code></pre>

donde

<pre><code>
type Nombre = String
</code></pre>

<pre><code>
type Subst = [(Nombre,Term)]
</code></pre>
## Ejercicios
### 1. (1.5): Alcance.
<div class=text-justify>
*Fórmula sobre la que tiene efecto un cuantificador.*
Define una función que devuelva el alcance de cada cuantificador contenido en una fórmula dada.
<pre><code>
	Practica04*> alcance (All "x" (Ex "y" (Pr "P" [V "x", V "y"])))
	[(Alle x (),Ein y (P([x,y]))),(Ein y (),P([x,y]))]
</code></pre>

### 2. (1.5): Variables ligadas.
<div class=text-justify>
*Conjunto de variables que son variables artificiales y entran en el alcance del cuantificador.*
Define una función que regrese todas las variables ligadas de una fórmula.
<pre><code>
	Practica04*> bv (All "x" (Ex "y" (Pr "P" [V "x", V "y", V "z"])))
	["x", "y"]
</code></pre>

### 3. (1.5): Variables libres.
*Conjunto de variables que no son ligadas.*
Define una función que regrese todas las variables libres de una fórmula.
<pre><code>
	Practica04*> fv (Ex "y" (Pr "P" [V "x", V "z"]))
	["x", "z"]
</code></pre>

### 4. (1.5): Sustitución de términos.
Define una función que aplique la sustitución de una variable sobre un término.
<pre><code>
	Practica04*> sustTerm F "f" [V "x", F "a" []] [("x", V "y")]
	f([y,a([])])
</code></pre>

### 5. (1.5): Sustitución de fórmulas.
Define una función que aplique la sustitución de una variable sobre una fórmula sin usar la α-equivalencia.
<pre><code>
	Practica04*> sustForm (Ex "x" (Pr "P" [V "x", V "y"])) [("y", F "a" [])]
	Ein x (P([x,a([])]))
</code></pre>

### 6. (2.5): α-equivalencia. 
*Dos fórmulas que únicamente difieren en el nombre de sus variables ligadas.*
Define una función que resuelva si dos fórmulas son α-equivalentes.
<pre><code>
Practica04*> alphaEq (Ex "x" (Pr "P" [V "x", V "z"])) (Ex "y" (Pr "P" [V "y", V "z"]))
True
</code></pre>
<pre><code>
Practica04*> alphaEq (Ex "y" (Pr "P" [V "w", V "z"])) (Ex "y" (Pr "P" [V "x", V "z"]))
False
</code></pre>

## Puntos Extra
### 1. (Hasta 2 puntos).
Implementa las funciones correspondientes al renombramiento de variables y la sustitución usando la α-equivalencia.

## Notas
- No olvides incluir todos los casos dentro de las funciones. En caso de no haber respuesta a alguno, se deberá mostrar alguna excepción o indicador.
- Si alguna de las reglas no puede aplicarse entonces debería devolver la misma solución que se recibió, pues no tuvo efecto pero debe continuar.
- Si necesitas mencionar peculiaridades sobre la ejecución de tu código, inclúyelas en el archivo README.
- Recuerda seguir los lineamientos del laboratorio.
- El archivo para la implementación de la práctica se encuentra en la sección del laboratorio de la página del curso.

# Bibliografía (COnsultas):
- [LPO en Haskell.](https://idus.us.es/bitstream/handle/11441/63139/Paluzo%20Hidalgo%20Eduardo%20TFG.pdf;jsessionid=4B5BBA65A8F4272E7AAE487CE5CD88A7?sequence=1)
