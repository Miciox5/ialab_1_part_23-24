
%APPLICABILE

% Controlla se la casella è vuota e 
applicabile(assegna(X), pos(Riga, Colonna)) :-
    vuota(pos(Riga, Colonna), 0),!,
    listaPossibili(pos(Riga, Colonna), Lista),
    length(Lista, Nvalori),
    Nvalori >= 1,
    member(X, Lista).

applicabile(assegna(X), pos(Riga, Colonna)) :-
    vuota(pos(Riga, Colonna), ValoreAsserito),
    ValoreAsserito \= 0,!,
    retract(vuota(pos(Riga, Colonna), ValoreAsserito)),
    assert(vuota(pos(Riga, Colonna), 0)),
    listaPossibili(pos(Riga, Colonna), Lista),
    length(Lista, Nvalori),
    Nvalori >= 1,
    member(X, Lista).

applicabile(scorriRiga,pos(Riga,Colonna)):-
    piena(pos(Riga,Colonna),_),
    valoreMax(MaxColonne),
    NuovaColonna is Colonna+1,
    NuovaColonna =< MaxColonne,!.

applicabile(cambiaRiga,pos(Riga,Colonna)):-
    piena(pos(Riga,Colonna),_),
    valoreMax(MaxRighe),
    NuovaRiga is Riga+1,
    NuovaRiga =< MaxRighe.

%AUSILIARI
listaPossibili(pos(Riga,Colonna),Lista):-
    possibiliRiga(Riga,ListaPoxValRiga),
    possibiliColonna(Colonna,ListaPoxColonna),
    possibiliGriglia(pos(Riga,Colonna),ListaPoxGriglia),
    %write(ListaPoxValRiga),
    %write(ListaPoxColonna),
    %write(ListaPoxGriglia),
    intersection(ListaPoxValRiga, ListaPoxColonna, TempIntersezione),
    intersection(TempIntersezione, ListaPoxGriglia, Lista).
    %write(Lista).
    

possibiliRiga(Riga,ListaPoxValRiga):-
    findall(Valore, piena(pos(Riga, _), Valore), ValoriPieneR),
    findall(Valore, vuota(pos(Riga, _), Valore), ValoriVuoteR),
    append(ValoriPieneR, ValoriVuoteR, ListaRiga),
    listaPoxVal(L),
    subtract(L, ListaRiga, ListaPoxValRiga).

possibiliColonna(Colonna,ListaPoxColonna):-
    findall(Valore, piena(pos(_, Colonna), Valore), ValoriPieneC),
    findall(Valore, vuota(pos(_, Colonna), Valore), ValoriVuoteC),
    append(ValoriPieneC, ValoriVuoteC, ListaColonna),
    listaPoxVal(L),
    subtract(L, ListaColonna, ListaPoxColonna).

possibiliGriglia(pos(Riga,Colonna),ListaPoxGriglia):-
    trovaGriglia(pos(Riga,Colonna), NumeroGriglia),
    trovaNumeriGriglia(NumeroGriglia, ValoriInGriglia),
    listaPoxVal(L),
    subtract(L, ValoriInGriglia, ListaPoxGriglia).

trovaGriglia(Posizione, NumeroGriglia) :-
    griglia(NumeroGriglia,ListaPosizioni),
    member(Posizione, ListaPosizioni),!.
    % clause(griglia(NumeroGriglia, ListaPosizioni), true).

% Aggiunti CUT, altrimenti andava su altre strade.
trovaNumeriGriglia(NumeroGriglia, ValoriInGriglia):-
    griglia(NumeroGriglia, ListaPosizioni),
    prendiValoriInGriglia(ListaPosizioni, ValoriInGriglia),!.

prendiValoriInGriglia([], []).
prendiValoriInGriglia([Posizione|RestoPosizioni], ValoriInGriglia):-
    findall(Valore, piena(Posizione, Valore), ValoriPiene),
    findall(Valore, vuota(Posizione, Valore), ValoriVuote),
    append(ValoriPiene, ValoriVuote, Valori),
    append(Valori, RestoValoriInGriglia, ValoriInGriglia),
    prendiValoriInGriglia(RestoPosizioni, RestoValoriInGriglia).

%TRASFORMA

% if:
trasforma(assegna(ValoreDaAssegnare),pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    % Se esiste un fatto vuota(pos(Riga, Colonna), _)
    vuota(pos(Riga, Colonna), _), 
    retract(vuota(pos(Riga, Colonna), _)),
    assert(vuota(pos(Riga, Colonna), ValoreDaAssegnare)),
    valoreMax(Max),
	NuovaColonna is Colonna+1,
    NuovaColonna =< Max.
% else:
trasforma(assegna(_),pos(Riga,_),pos(NuovaRiga,NuovaColonna)):-
    % Se non esiste un fatto vuota(pos(Riga, Colonna), _)
    NuovaColonna is 1,
    NuovaRiga is Riga+1.
    
trasforma(scorriRiga,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    NuovaColonna is Colonna+1.

trasforma(cambiaRiga,pos(Riga,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is Riga+1,
    NuovaColonna is 1.

trasforma(ricomincia,pos(_,Colonna),pos(NuovaRiga,NuovaColonna)):-
	valoreMax(Max),
    Colonna > Max,
   	NuovaRiga is 1,
    NuovaColonna is 1.

