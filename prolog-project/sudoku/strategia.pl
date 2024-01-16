strategiaDiRicerca(Cammino):-
    iniziale(pos(RStart,CStart)),
    risolvi(pos(RStart,CStart),Cammino).


risolvi(_,[]):-
    finale,!,
    listing(vuota/2).

risolvi(S,[Azione|ListaAzioni]):-
    applicabile(Azione,S),
    trasforma(Azione,S,SNuovo),
    risolvi(SNuovo,ListaAzioni).




