%Ejercicio 1
%Devuelve true o false dependiendo si 
%Un numero essta contenido en la lista
%Prueba : elemento(3,[1,2,3,2]).

elemento(X,[X|_]).
elemento(X,[_|C]) :- elemento(X,C). 


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
