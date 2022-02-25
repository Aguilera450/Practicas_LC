# Práctica 01: Introducción a Haskell
## Ejercicios
### 1. (1.5 puntos) **Anagrama.**
*Cambio de orden de las letras de una palabra o frase que da lugar a otra
frase o palabra distinta.*


&nbsp;
Dadas dos cadenas, resuelve si la segunda es un anagrama de la primera o no.
<pre><code>
Practica1*> anagrama "enamoramientos" "armoniosamente"
True
</code></pre>

### 2. (1 punto)
Devuelve la lista de los elementos contenidos en la lista dada entre los
índices indicados.
<pre><code>
Practica1*> segmento 2 4 [1, 8, 3, 7, 9]
[8, 3, 7]
</code></pre>

### 3. (1 punto)
Dada una lista de enteros, devuelve el producto del número que tenga mas
repeticiones dentro de la lista.
<pre><code>
Practica1*>prodReps [2, 5, 75, 3, 3, 4, 52, 3]       --El número que más se repite es 3.
27                                                   --pues 3x3x3
</code></pre>

### 4. (1 punto) **Fechas espejo.**
Son llamadas así las fechas únicas en el calendario tales que al escribirlas
en formato dd.mm.aaaa pueden leerse al derecho y al revés sin cambiar la fecha,
como un espejo. Dada una fecha en formato "ddmmaaaa", define una función tal
que decida si una fecha es o no, espejo.
<pre><code>
Practica1*> esEspejo "22022022"
True
</code></pre>
<pre><code>
Practica1*> esEspejo "17121998"
False
</code></pre>

### 5. (1 punto)
Dado un entero y una lista de enteros, elimina el entero que se encuentra en el
indice indicado y devuelve la lista.
<pre><code>
Practica1*> elimina [3,6,2,6,8,9] 4
[3, 6, 2, 6, 9]
</code></pre>

### 6. (3 punto)
Recordando la definición de los números binarios vista en clase, define las siguientes
funciones:
a) La suma de dos números binarios.

       <pre><code>
       Practica01*> suma (Uno (Cero (Uno U))) (Cero (Uno U))
       10011
       </code></pre>

b) El antecesor de un número binario.

       <pre><code>
       Practica01*> antecesor (Uno (Cero (Uno (Cero (Uno U)))))
       110100
       </code></pre>

### 7. (1.5 puntos)
Dada la gramática para las operaciones aritméticas, implementa la instancia de la clase
Show para poder visualizarla como solemos ocuparlos.