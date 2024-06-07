%APPLICABILE

% Euristica: singoli ovvi. A differenza di prima, applica l'azione solo se
%   la cella vuota ha solo un valore possibile
applicabile(assegna(X),pos(Riga,Colonna)):-
    vuota(pos(Riga,Colonna),0),
    listaPossibili(pos(Riga,Colonna),Lista),
    length(Lista, Nvalori),
    Nvalori == 1,
    nth1(1, Lista, X),!.

% Se fallisce l'assegnamento precedente (se non c'è il singolo) 
%   scorro la riga anche se rimane la cella vuota 
applicabile(scorriRiga,pos(Riga,Colonna)):- 
    vuota(pos(Riga,Colonna),_),
    valoreMax(MaxColonne),
    NuovaColonna is Colonna+1,
    NuovaColonna =< MaxColonne,!.

% Se non c'è il singolo, scorro la riga anche se rimane la cella vuota 
applicabile(scorriRiga,pos(Riga,Colonna)):- %
    piena(pos(Riga,Colonna),_),
    valoreMax(MaxColonne),
    NuovaColonna is Colonna+1,
    NuovaColonna =< MaxColonne,!.

% Se non c'è il singolo e devo cambiare riga anche se rimane cela vuota
applicabile(cambiaRiga,pos(Riga,Colonna)):- 
    vuota(pos(Riga,Colonna),_),
    valoreMax(MaxRighe),
    NuovaRiga is Riga+1,
    NuovaRiga =< MaxRighe,!.

% Se non c'è il singolo e devo cambiare riga anche se rimane cela vuota
applicabile(cambiaRiga,pos(Riga,Colonna)):- 
    piena(pos(Riga,Colonna),_),
    valoreMax(MaxRighe),
    NuovaRiga is Riga+1,
    NuovaRiga =< MaxRighe,!.

% se arriva al fondo, ricomincia la ricerca
applicabile(ricomincia,pos(Riga,_)):- 
    valoreMax(Max),
    Riga>=Max,!.

%AUSILIARI

% Ritorna la lista dei possibili valori di una cella vuota
listaPossibili(pos(Riga,Colonna),Lista):-
    possibiliRiga(Riga,ListaPoxValRiga),
    possibiliColonna(Colonna,ListaPoxColonna),
    possibiliGriglia(pos(Riga,Colonna),ListaPoxGriglia),
    intersection(ListaPoxValRiga, ListaPoxColonna, TempIntersezione),
    intersection(TempIntersezione, ListaPoxGriglia, Lista),!.
    
% Ritorna i valori possibili di una cella esaminando la riga
possibiliRiga(Riga,ListaPoxValRiga):-
    findall(Valore, piena(pos(Riga, _), Valore), ValoriPieneR),
    findall(Valore, vuota(pos(Riga, _), Valore), ValoriVuoteR),
    append(ValoriPieneR, ValoriVuoteR, ListaRiga),
    listaPoxVal(L),
    subtract(L, ListaRiga, ListaPoxValRiga),!.

% Ritorna i valori possibili di una cella esaminando la colonna
possibiliColonna(Colonna,ListaPoxColonna):-
    findall(Valore, piena(pos(_, Colonna), Valore), ValoriPieneC),
    findall(Valore, vuota(pos(_, Colonna), Valore), ValoriVuoteC),
    append(ValoriPieneC, ValoriVuoteC, ListaColonna),
    listaPoxVal(L),
    subtract(L, ListaColonna, ListaPoxColonna),!.

% Ritorna i valori possibili di una cella esaminando la griglia
possibiliGriglia(pos(Riga,Colonna),ListaPoxGriglia):-
    trovaGriglia(pos(Riga,Colonna), NumeroGriglia),
    trovaNumeriGriglia(NumeroGriglia, ValoriInGriglia),
    listaPoxVal(L),
    subtract(L, ValoriInGriglia, ListaPoxGriglia),!.

% Ritorna la griglia di Posizione
trovaGriglia(Posizione, NumeroGriglia) :-
    griglia(NumeroGriglia,ListaPosizioni),
    member(Posizione, ListaPosizioni),!.

% Ritorna i valori delle celle della griglia n=NumeroGriglia
trovaNumeriGriglia(NumeroGriglia, ValoriInGriglia):-
    griglia(NumeroGriglia, ListaPosizioni),
    prendiValoriInGriglia(ListaPosizioni, ValoriInGriglia),!.

% Chiamata ricorsiva per prendere i valori nella griglia
prendiValoriInGriglia([], []).
prendiValoriInGriglia([Posizione|RestoPosizioni], ValoriInGriglia):-
    findall(Valore, piena(Posizione, Valore), ValoriPiene),
    findall(Valore, vuota(Posizione, Valore), ValoriVuote),
    append(ValoriPiene, ValoriVuote, Valori),
    append(Valori, RestoValoriInGriglia, ValoriInGriglia),
    prendiValoriInGriglia(RestoPosizioni, RestoValoriInGriglia).

%TRASFORMA

% If: Applica l'assegnamento effettivo sulla cella vuota 
trasforma(assegna(ValoreDaAssegnare),pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    % Se esiste un fatto vuota(pos(Riga, Colonna), _)
    vuota(pos(Riga, Colonna), _), 
    retract(vuota(pos(Riga, Colonna), _)),
    assert(vuota(pos(Riga, Colonna), ValoreDaAssegnare)),
    valoreMax(Max),
    NuovaColonna is Colonna+1,
    NuovaColonna =< Max.

% else: Prosegue senza applicare l'assegnamento (caso di fallimento)
trasforma(assegna(_),pos(Riga,_),pos(NuovaRiga,NuovaColonna)):-
    % Se non esiste un fatto vuota(pos(Riga, Colonna), _)
    NuovaColonna is 1,
    NuovaRiga is Riga+1,!.
    
% Scorre l'esecuzione sulla prossima cella in riga
trasforma(scorriRiga,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    NuovaColonna is Colonna+1,!.

% Scorre l'esecuzione sulla prossima cella in colonna
trasforma(cambiaRiga,pos(Riga,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is Riga+1,
    NuovaColonna is 1,!.

% Ricomincia l'esecuzione se arriva al fondo
trasforma(ricomincia,pos(_,Colonna),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is 1,
    NuovaColonna is 1,!.

