# Práctica 02: Lógica proposicional en Haskell
## Ejercicios
### Contexto:
Se define al tipo de dato Prop para representar los operadores lógicos de la lógica proposicional:
<pre><code>
	data Prop = PTrue | PFalse | PVar String | PNeg Prop | POr Prop Prop
	     	  | PAnd Prop Prop | PImpl Prop Prop | PEquiv Prop Prop
<\code><\pre>
Al Estado como la lista de las variables con valor verdadero dentro de la proposición.
<pre><code>
type Estado = [String]
<\code><\pre>

### 1. (1 punto):
Define una función que devuelve la interpretación de la proposición con el estado dado.
<pre><code>
Practica02*> interp ["p"] (PAnd (PVar "p") (PVar "q"))
False
Practica02*> interp ["p"] (POr (PVar "p") (PVar "q"))
True
</code></pre>

### 2. (0.5 puntos):
Define una función que obtenga una lista con todas las combinaciones de posibles estados
para una proposición.
<pre><code>
Practica02*> estados (PEquiv (PVar "p") (PVar "q"))
[["p", "q"], ["p"], ["q"], []]
</code></pre>

### 3. (1 punto):
Define una función que devuelva la lista de todas las variables contenidas en una proposición.
<pre><code>
Practica02*> vars (PImpl (PVar "p") (PVar "q"))
["p", "q"]
<\code><\pre>

### 4. (1 punto):
Define una función que obtenga el conjunto potencia de una lista.
<pre><code>
Practica02*> subconj [1, 2, 3]
[[1, 2, 3], [1, 2], [1, 3], [2, 3], [1], [2], [3], []]
<\code><\pre>

### 5. (0.5 puntos):
Define una función que devuelva la lista de los modelos para la proposición dada.
<pre><code>
Practica02*> modelos (PImpl (PVar "p") (PVar "q"))
[["p", "q"], ["q"], []]
<\code><\pre>

### 6. (0.5 puntos):
Define una función que resuelva si la proposición dada es una tautología.
<pre><code>
Practica02*> tautologia (POr (PVar "p") (PNeg (PVar "p")))
True
Practica02*> tautologia (PAnd (PVar "p") (PVar "q"))
False
<\code><\pre>

### 7. (0.5 puntos):
Define una función que resuelve si una proposición es satisfacible para cierto estado.
<pre><code>
Practica02*> satisfen ["p"] (PEquiv (PVar "p") (PVar "q"))
False
<\code><\pre>

### 8. (0.5 puntos):
Define una función que diga si una proposición es satisfacible.
<pre><code>
Practica02*> satisf (PImpl (PVar "p") (PVar "q"))
True
<\code><\pre>

### 9. (0.5 puntos):
Define una función que resuelva si una proposición es insatisfacible para el estado dado.
<pre><code>
Practica02*> insatisfen ["p"] (PEquiv (PVar "p") (PVar "q"))
True
<\code><\pre>

### 10. (0.5 puntos):
Define una función que resuelva si una proposición es una contradicción.
<pre><code>
Practica02*> contrad (POr (PVar "p") (PVar "q"))
False
Practica02*> contrad (PAnd (PVar "p") (PNeg (PVar "p")))
True
<\code><\pre>

### 11. (0.5 puntos):
Define una función que verifique si dos proposiciones son equivalentes.
<pre><code>
Practica02*> equiv (POr (PVar "p") (PVar "q")) (PNeg (PNeg (POr (PVar "p") (PVar "q"))))
True
<\code><\pre>

### 12. (1 punto)
Define una función que elimine las equivalencias de la proposición dada.
<pre><code>
Practica02*> elimEquiv (PEquiv (PVar "p") (PVar "q"))
(("p" -> "q") ^ ("q" -> "p"))
<\code><\pre>

### 13. (1 punto.):
Define una función que elimine las implicaciones de la proposición dada.
<pre><code>
Practica02*> elimImpl (PImpl (PVar "p") (PVar "q"))
(~"p" v "q")
<\code><\pre>

### 14. (1 punto):
Define una función que aplique las leyes de De Morgan.
<pre><code>
Practica02*> deMorgan (PNeg (POr (PVar "p") (PVar "q")))
(~"p" ^ ~"q")
<\pre><\code>

### Extra. (1.5 puntos):
Implementa todas las extensiones a conjuntos para las funciones que generan los estados, modelos y resuelven la satisfacibilidad. Esta sección viene en el archivo de la práctica, deberás descomentarlo y describir cada función. Si tus funciones para los conjuntos son correctas, podrán utilizarse las funciones de consecuencia lógica y verificación de argumentos correctos (es consideración para otorgar el punto extra).
<pre><code>
estadosConj :: [Prop] -> [Estado]
modelosConj :: [Prop] -> [Estado]
satisfenConj:: Estado -> [Prop] -> Bool
satisfConj:: [Prop] -> Bool
insatisfenConj:: Estado -> [Prop] -> Bool
insatisfConj:: [Prop] -> Bool
<\code><\pre>
#### *Nota: Esta prohibido utilizar la función ’map’ de Haskell.*

## Bibliografía (Consultas):
* [Haskell.](https://www.haskell.org/)
* [Recursión.](http://aprendehaskell.es/content/Recursion.html)
* [La sintaxis de las funciones.](http://aprendehaskell.es/content/Funciones.html)
* [Creando nuestros propios tipos y clases de tipos.](http://aprendehaskell.es/content/ClasesDeTipos.html)