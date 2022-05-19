%Ejercicio 1
%Devuelve true o false dependiendo si 
%Un numero essta contenido en la lista
%Prueba : elemento(3,[1,2,3,2]).

elemento(X,[X|_]).
elemento(X,[_|C]) :- elemento(X,C). 

/*
* Especificación del programa lógico para ejercicio 2.
*/
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Inciso (a):
    % Hechos:
    % Nos indica cuáles son estaciones:
    estacion(mochis).
    estacion(fuerte).
    estacion(bahuichivo).
    estacion(davisero).
    estacion(creel).
    
    % Nos indica adyacencia entre dos estaciones.
    ady(mochis, fuerte).
    ady(fuerte, bahuichivo).
    ady(bahuichivo, davisero).
    ady(davisero, creel).
    
    % Nos indica si puedo llegar de una estación a su anterior o siguiente.
    flecha(X, Y) :- ady(X, Y).
    flecha(Y, X) :- ady(X, Y).
    
    trayectoria_ida(X, X) :- estacion(X).
    trayectoria_ida(X, Z) :- flecha(X, Y), trayectoria_ida(Y, Z).
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Inciso (b):
    camino(X, Y, [X|Cs]) :- camino(X, Y, [X], Cs).

    camino(X, X, _, []).
    camino(X, Y, Visitados, [Z|Cs]) :- flecha(X, Z), no_esta(Z, Visitados), camino(Z, Y, [Z|Visitados], Cs).
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Inciso (c):
    % Relaciones entre los caminos que se pueden formar en las estaciones:
    es_camino(X, Y) :- es_camino(X, Y, [X]).
    
    es_camino(X, X, _) :- estacion(X).
    es_camino(X, Z, Visitadas) :- flecha(X, Y), no_esta(Y, Visitadas),es_camino(Y, Z, [Y|Visitadas]).
    
    % Auxiliar:
    no_esta(_,[]).
    no_esta(X,[Y|Ys]) :- X \== Y, no_esta(X,Ys).
    
%Ejercicio 3
%Funcion para  saber si es primo un numero
%Contiene una funcion auxiliar, compara
%con la cual obtenemos el modulo del numero
%en caso de ser primo se ira sumando hasta 
%igualar el contador
%Prueba : esprimo(7)

esprimo(A) :- A > 1, compara(A,2).
compara(A,B) :- 
				B >= A
				-> true
				; 0 is A mod B
				-> false
				; succ(B,C), compara(A,C).

%Ejercicio 4
%Eliminando duplicados de una lista
%Donde: C: cabeza, Cl: cola, E: elemento
%Y llamamos a la funcion del ejercicio 1
%Prueba : eliminar([1,2,3,2], E).

eliminar([],[]).
eliminar([C|Cl],E) :- elemento(C,Cl), !, eliminar(Cl,E).
eliminar([C|Cl],[C|E]) :- eliminar(Cl,E).


/*
* Especificación del programa lógico para ejercicio 5.
*/

    % A Alexia y David les gusta leer
    gustar_leer(alexia).
    gustar_leer(david).
    
    % Alexia lee "Alicia en el País de las Maravillas" del autor Lewis Carroll
    lee(alexia, alicia_en_el_pais_de_las_maravillas).
    lee(david, clima). % David lee
    autor(alicia_en_el_pais_de_las_maravillas, lewis_caroll).
    
    % David lee si el clima es nuboso o lluvioso
    como_es(clima, lluvioso ; nuboso).
    
    % Alexia odia el clima lluvioso.
    odiar(alexia, clima_lluvioso).
    
/*
* Ejercicio 6
* la logica esta anexado en un pdf
*/

esta_relacionado(autor,niño).
esta_relacionado(padre,niña).
esta_relacionado(autor,padre).
esta_relacionado(padre,autor).
esta_relacionado(autor,hija).

abuelo(X,Z) :- esta_relacionado(X,Y), esta_relacionado(Y,Z).
