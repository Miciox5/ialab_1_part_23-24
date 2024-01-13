strategiaDiRicerca(Cammino):-
    iniziale(pos(RStart,CStart)),
    risolvi(pos(RStart,CStart),Cammino).


risolvi(pos(R,C),_):-
    finale,!,
    write('Lista celle finale:'),nl,
    listing(cella/2).

risolvi(S,[Azione|ListaAzioni]):-
    applicabile(Azione,S),
    trasforma(Azione,S,SNuovo),
    risolvi(SNuovo,ListaAzioni).

