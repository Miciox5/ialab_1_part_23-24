strategiaDiRicerca(Cammino):-
    iniziale(pos(RStart,CStart)),
    RStart == CStart, CStart == 1,
    risolvi(pos(RStart,CStart),Cammino,[]),!.

% strategiaDiRicerca(Cammino):-
%     retractall(pos(_,_)),
%     assert(pos(1,1)),
%     iniziale(S0),
%     risolvi(S0,Cammino,[]),!.

risolvi(S,[],_):-
    finale.

risolvi(S,[_|_],_):-
    applicabile(Azione,S),
    trasforma(Azione,S,SNuovo),
    risolvi(SNuovo,[_|_],_),!.


% TO-DO: tentativo di stop sull'azione di ricomincia
% risolvi(pos(Riga,Colonna),[_|_],_):-
%     applicabile(ricomincia,S),
%     trasforma(ricomincia,S,SNuovo).

%% CONCLUSIONE:
%   Attualmente, la scansione viene fatta in loop, stampando
%   le posizioni delle caselle vuote, che in questo caso sono fatti
%   non definiti.