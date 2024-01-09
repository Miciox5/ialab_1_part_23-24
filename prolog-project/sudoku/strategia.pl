strategiaDiRicerca(Cammino):-
    iniziale(pos(RStart,CStart)),
    risolvi(pos(RStart,CStart),Cammino).

% strategiaDiRicerca(Cammino):-
%     retractall(pos(_,_)),
%     assert(pos(1,1)),
%     iniziale(S0),
%     risolvi(S0,Cammino,[]),!.

risolvi(_,[]):-
    finale.

risolvi(S,[Azione|ListaAzioni]):-
    applicabile(Azione,S),
    trasforma(Azione,S,SNuovo),
    risolvi(SNuovo,ListaAzioni).


% TO-DO: tentativo di stop sull'azione di ricomincia
% risolvi(pos(Riga,Colonna),[_|_],_):-
%     applicabile(ricomincia,S),
%     trasforma(ricomincia,S,SNuovo).

%% CONCLUSIONE:
%   Attualmente, la scansione viene fatta in loop, stampando
%   le posizioni delle caselle vuote, che in questo caso sono fatti
%   non definiti.