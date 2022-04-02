# Práctica 03

## Contexto:
<div class=text-justify>
 
  Una vez implementada la práctica anterior sobre lógica proposicional, se podrán definir funciones para modificar proposiciones en sus formas normales.

Además, el algoritmo DPLL ayuda a resolver si una fórmula es satisfacible y en su caso con que valores.
El algoritmo parte del cumplimiento de ciertas reglas, mismas que se implementarán en esta práctica para ello, es necesario agregar las siguientes definiciones a la grámatica:

<pre><code>
	type Literal = Prop
	type Clausula = [Literal]
	type Formula = [Clausula]
	type Modelo = [Literal]
	type Solucion = (Modelo, Formula)
</code></pre>

## Ejercicios

### Formas Normales
#### 1. (1 punto): Forma Normal Negativa.
*Proposición en la cual solo hay negaciones sobre variables. Una literal, PTrue y PFalse ya están en fnn.*
Define una función que dada una proposición sin implicaciones ni equivalencias, devuelva su forma normal negativa.
<pre><code>
	Practica03*> fnn (PVar "p")
	p
	Practica03*> fnn (PNeg (PNeg (PAnd (PVar "p") (PVar "q"))))
	("p" ^ "q")
	Practica03*> fnn (PNeg (PAnd (PVar "p") (PVar "q")))
	(~"p" v ~"q") -- Por las leyes de De Morgan.
</code></pre>

#### 2. (1 punto) Forma Normal Conjuntiva.
*Proposición que solo contiene la conjunción de cláusulas, donde las cláusulas pueden ser la disyunción de literales, PTrue o PFalse. Las literales, PTrue y PFalse ya están en fnc.*
Define una función que dada una proposición en FNN, devuelva su forma normal conjuntiva.
**Hint:** Para fnc es necesario implementar la función "distr"que aplica las leyes de distribuitividad recibiendo dos proposiciones.
<pre><code>
	Practica03*> fnc (PNeg (PVar "p"))
	~"p"
	Practica03*> fnc (PAnd (PVar "p") (PVar "q"))
	("p" ^ "q")
	Practica03*> fnc (POr (PAnd (PVar "p") (PVar "r")) (PVar "q"))
	(("p" v "q") ^ ("r" v "q"))
</code></pre>

### Algoritmo DPLL
#### 1. (1 punto) Regla unit.
*Regla que pasa una literal que esté dentro de la fórmula como una cláusula al modelo.*
Define una función que aplique la regla unit sobre una solución.
<pre><code>
	Practica03*> unit ([], [[PNeg (PVar "p")], [PVar "p", PVar "r"]])
	([PNeg (PVar "p")], [[PVar "p", PVar "r"]])
</code></pre>

#### 2. (1 punto) Regla elim.
*Regla que elimina de la fórmula las cláusulas que contienen la literal del modelo.*
Define una función que aplique la regla elim sobre una solución.
<pre><code>
	Practica03*> elim ([PVar "p"], [[PVar "p", PVar "r"], [PNeg (PVar "p"), PVar "q"]])
	([PVar "p"], [[PNeg (PVar "p"), PVar "q"]])
</code></pre>

#### 3. (1 punto) Regla red.
*Regla que quita las literales contrarias a la del modelo en la fórmula.*
Define una función que aplique la regla red sobre una solución.
<pre><code>
	Practica03*> red ([PVar "p"], [[PVar "s", PVar "r"], [PNeg (PVar "p"), PVar "q"]])
	([PVar "p"], [[PVar "s", PVar "r"], [PVar "q"]])
</code></pre>

#### 4. (1 punto) Regla split.
*Regla que genera dos caminos de búsqueda (o análisis de casos) donde en los posibles modelos, uno contiene la literal negada y en el otro no.*
Define una función que aplique la regla split sobre una solución y la primer literal que aparezca en la primer clúausula de la fórmula.
Como no habrá un usuario que elija la literal para dividir, el algoritmo deberá usar la primer literal dentro de la primer cláusula de la fórmula.
<pre><code>
	Practica03*> split ([], [[PVar "s", PVar "r"], [PNeg (PVar "p"), PVar "q"]])
	[([PVar "s"], [[PVar "s", PVar "r"], [PNeg (PVar "p"), PVar "q"]]),
	([PNeg (PVar "s")], [[PVar "s", PVar "r"], [PNeg (PVar "p"), PVar "q"]])]
</code></pre>

#### 5. (1 punto) Regla conflict.
*Regla final en la que se llega a una contradicción, es decir, una literal está en el modelo y su contraria esta en la fórmula como una cláusula.*
Define una función que resuelva si se llego a una contradicción.
<pre><code>
	Practica03*> conflict ([PNeg (PVar "s")], [[PVar "s", PVar "r"], [PVar "s"]])
	True
	Practica03*> conflict ([PNeg (PVar "s")], [[PVar "s", PVar "r"], [PVar "q"]])
	False
</code></pre>

#### 6. (1 punto) Regla success.
*Regla final que se determina si se llegó a una interpretación que satisface la fórmula. Esto se sabe si la fórmula ha quedado vacía.*
Define una función que resuelva si se ha llegado a una interpretación que satisfaga la fórmula.
<pre><code>
	Practica03*> success ([PNeg (PVar "p"), PVar "r"], [])
	True
	Practica03*> success ([PNeg (PVar "p")], [[PVar "s", PVar "r"]])
	False
</code></pre>

#### 7. (2 punto) DPLL.
Define una función que aplique las reglas básicas, obteniendo la solución referente a ese paso.
<pre><code>
	Practica03*> appDPLL ([PVar "p"], [[PVar "s", PVar "r"], [PNeg (PVar "p"), PVar "q"]])
	([PNeg (PVar "p")], [[PVar "s", PVar "r"], [PVar "q"]]) -- Por red.
</code></pre>

### Puntos Extra
#### 1. (2 puntos).
Define una función que aplique las reglas básicas y split hasta obtener conflict o success, y en cualquiera de los casos, devolver el modelo formado. Notése que si es satisfacible, la lista de la fórmula será vacía, en el caso opuesto, se notará la variable que creó el conflicto.
<pre><code>
	Practica03*> dpll ([], [[p], [PNeg (PVar "p"), PNeg (PVar "q")], [PVar "p", PVar "s"], [PVar "q", PVar "s"]])
	([PVar "p", PNeg (PVar "q"), PVar "p"], [])
</code></pre>

### Notas
- Para esta práctica deberás importar tu Practica2.hs y ocupar las funciones definidas.
- Para los casos en los que las funciones no tiene respuesta, puede ignorarse o de ser posible, informar al usuario con un error el porqué no es posible manejarlo.
- Si alguna de las reglas no puede aplicarse entonces debería devolver la misma solución que se recibió pues no tuvo efecto pero debe continuar.
- Si necesitas mencionar peculiaridades sobre la ejecución de tu código, inclúyelas en el archivo README.
-  Nunca olvides seguir los lineamientos del laboratorio.
- El archivo para la implementación de la práctica se encuentra en la sección del laboratorio de la página del curso.



## Bibliografía (Consultas):
* [dpll.](https://github.com/parsonsmatt/dpll/blob/master/src/DPLL.hs)
* [Razonamiento artifial.](https://es.coursera.org/lecture/razonamiento-artificial/algoritmo-dpll-2Zhbm)
* [Formas normales en Haskell.](https://www.glc.us.es/~jalonso/vestigium/lmf2012-formas-normales-en-haskell/)
* [Algoritmo DPLL (Davis, Putnam, Logemann y Loveland).](https://www.glc.us.es/~jalonso/vestigium/lmf2013-algoritmo-dpll-davis-putnam-logemann-y-loveland/)
