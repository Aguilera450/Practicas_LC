%Ejercicio 1
%Devuelve true o false dependiendo si 
%Un numero essta contenido en la lista

elemento(X,[X|_]).
elemento(X,[_|C]) :- elemento(X,C). 


%Ejercicio 3
%Funcion para  saber si es primo un numero
%Contiene una funcion auxiliar, compara
%con la cual obtenemos el modulo del numero
%en caso de ser primo se ira sumando hasta 
%igualar el contador

esprimo(A) :- A > 1, compara(A,2).
compara(A,B) :- 
				B >= A
				-> true
				; 0 is A mod B
				-> false
				; succ(B,C), compara(A,C).



