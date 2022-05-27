%practica06

%Ejercicio 1 lo dividimos en dos partes
% Parte a) Convertimos de caracteres a binario

char(a,01100001).
char(b,01100010).
char(c,01100011).
char(d,01100100).
char(e,01100101).
char(f,01100110).
char(g,01100111).
char(h,01101000).
char(i,01101001).
char(j,01101010).
char(k,01101011).
char(l,01101100).
char(m,01101101).
char(n,01101110).
char(o,01101111).
char(p,01110000).
char(q,01110001).
char(r,01110010).
char(s,01110011).
char(t,01110100).
char(u,01110101).
char(v,01110110).
char(w,01110111).
char(x,01111000).
char(y,01111001).
char(z,01111010).

% Tenemos el caso base por si nos pasan una lista vacia, 
%  devolvemos una lista vacia 
char_binario([],[]) :- char(_,_).
% Sige el caso donde solo hay un elemento en la lista
char_binario([X],[Y]) :- char(X,Y).
char_binario([X],[Y]) :- char(Y,X).
% Finalmente el caso donde recorremos la lista 
char_binario([X|XS],[Y|YS]) :- char(X,Y), char_binario(XS,YS).
char_binario([X|XS],[Y|YS]) :- char(Y,X), char_binario(XS,YS).

%
% 
% Parte b) Convertimos de binario a caracteres

binario(01100001,a).
binario(01100010,b).
binario(01100011,c).
binario(01100100,d).
binario(01100101,e).
binario(01100110,f).
binario(01100111,g).
binario(01101000,h).
binario(01101001,i).
binario(01101010,j).
binario(01101011,k).
binario(01101100,l).
binario(01101101,m).
binario(01101110,n).
binario(01101111,o).
binario(01110000,p).
binario(01110001,q).
binario(01110010,r).
binario(01110011,s).
binario(01110100,t).
binario(01110101,u).
binario(01110110,v).
binario(01110111,w).
binario(01111000,x).
binario(01111001,y).
binario(01111010,z).

binario_char([],[]) :- binario(_,_).
binario_char([X],[Y]) :- binario(X,Y).
binario_char([X],[Y]) :- binario(Y,X).
binario_char([X|XS],[Y|YS]) :- binario(X,Y), binario_char(XS,YS).
binario_char([X|XS],[Y|YS]) :- binario(Y,X), binario_char(XS,YS).

%---------------- Ejercicio 02
:- dynamic(sobre/2).
:- dynamic(bloqueado/1).
% sobre(X,Y) - X está sobre Y
sobre(gris,rojo).
sobre(rojo,azul).
sobre(amarillo,rosa).
% hastaArriba(X) - X es el cubo más arriba en su pila de cubos.
hastaArriba(X) :- not(bloqueado(X)).
%  bloqueado(X) - X tiene un cubo encima
bloqueado(rojo).
bloqueado(azul).
bloqueado(rosa).
% hastaAbajo(X) - X es el cubo que se encuentre hasta el fondo de su pila de cubos.
hastaAbajo(X) :- not(sobre(X,_)).
% mover(X,Y) - nos permite mover X sobre Y si este último esta encima.
mover(X,Y) :- sobre(Y,X), !, assert(bloqueado(Y)),retract(sobre(Y,X)),revisa(X,Y), intercambia(X,Y).
% revisa(X,Y) - relación auxiliar que revisa si al mover el cubo este se debe bloquear o no
revisa(X,Y) :- sobre(Z,Y), !, assert(sobre(Z,X)), assert(bloqueado(X)); retract(bloqueado(X)).
% intercambia(X,Y) - relación auxiliar que intercambia el cubo debajo del original si es debido
intercambia(X,Y) :- sobre(X,Z), !, assert(sobre(Y,Z)), retract(sobre(X,Z)), assert(sobre(X,Y)); assert(sobre(X,Y)).

%---------------- Ejercicio 03
% Estados finales:
estado_final(q1).
estado_final(q2).

% Estado inicial:
estado_inicial(q0).

% Trancisiones:
transicion(q0, b, q2).
transicion(q0, b, q1).
transicion(q0, b, q3).
transicion(q1, a, q1).
transicion(q1, b, q1).
transicion(q2, a, q1).
transicion(q3, b, q0).

% Funcion auxiliar a "aceptar":
termina(X, []) :- estado_final(X).
termina(X, [Y|L]) :- transicion(X, Y, E), termina(E, L).

% Función que acepta las cadenas (listas) syss el autómata las procesa:
aceptar([S|L]) :- termina(q0, [S|L]).

% --Ejercicio 4

ordseleccion([],[]).
ordseleccion(L1,[X|L2]) :- menor(X,L1,L3), ordseleccion(L3,L2).
menor(X,L1,L2) :- select(X,L1,L2), not((member(Y,L2), Y =< X)).


% Si mezclamos dos listas vacias, el resultado es la lista vacia

mezclar([],[],[]).  

% Si recibimos una lista vacia y hacemos mezcla con una lista que si contiene elementos
%  el resultado será unicamente la lista con sus mismos elementos y como ya estan ordenados
%  es satisfactorio el resultado

mezclar(L,[],L). 
mezclar([],L, L).

mezclar([A|As], [B|Bs], [A|Cs]):- A<B,!, mezclar(As, [B|Bs], Cs), ordenada([A|Cs]).  
mezclar([A|As], [B|Bs], [A,B|Cs]):- A=B,!,mezclar(As, Bs, Cs), ordenada([A,B|Cs]). 
mezclar([A|As], [B|Bs], [B|Cs]):- A>B,!, mezclar([A|As], Bs, Cs), ordenada([B|Cs]). 

ordenada([]).
ordenada([_]).
ordenada([X,Y|Ys]) :- X<Y, ordenada([Y|Ys]).
