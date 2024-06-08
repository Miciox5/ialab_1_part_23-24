% Predicato wrapper per risolvi
strategiaDiRicerca(Cammino):-
    iniziale(pos(RStart,CStart)),
    risolvi(pos(RStart,CStart),Cammino).

% Verifica del predicato finale con conseguente stampa
%   della soluzione.
risolvi(_,[]):-
    finale,!,
    listing(vuota/2).

% Applicazione della strategia di ricerca in profondità
risolvi(S,[Azione|ListaAzioni]):-
    applicabile(Azione,S),
    trasforma(Azione,S,SNuovo),
    risolvi(SNuovo,ListaAzioni).




