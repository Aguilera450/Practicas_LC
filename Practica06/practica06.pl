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
binario_char([],[]) :- binario(_,_).
binario_char([X],[Y]) :- binario(X,Y).
binario_char([X],[Y]) :- binario(Y,X).
binario_char([X|XS],[Y|YS]) :- binario(X,Y), binario_char(XS,YS).
binario_char([X|XS],[Y|YS]) :- binario(Y,X), binario_char(XS,YS).

%---------------- Ejercicio 02

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
