lista1([cella(pos(1,2),3)]).
lista2([]).

start:-
    lista1(L1),
    lista2(L2),
    append(L1,L2,L3),
    write(L3),nl.
