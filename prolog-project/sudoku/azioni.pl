%APPLICABILE

% Applica un assegnamento e prosegue nella ricerca in profondità 
applicabile(assegna(X), pos(Riga, Colonna)) :-
    vuota(pos(Riga, Colonna), ValoreAsserito),
    ( ValoreAsserito \= 0 ->
        retract(vuota(pos(Riga, Colonna), ValoreAsserito)),
        assert(vuota(pos(Riga, Colonna), 0))
    ; % Altrimenti, prosegui senza retract
        true
    ),
    listaPossibili(pos(Riga, Colonna), Lista),
    length(Lista, Nvalori),
    Nvalori >= 1,
    member(X, Lista).

% Scorre la riga se trova la cella piena
applicabile(scorriRiga,pos(Riga,Colonna)):-
    piena(pos(Riga,Colonna),_),
    valoreMax(MaxColonne),
    NuovaColonna is Colonna+1,
    NuovaColonna =< MaxColonne,!.

% Scorre la colonna se trova la cella piena ed è a fine riga
applicabile(cambiaRiga,pos(Riga,Colonna)):-
    piena(pos(Riga,Colonna),_),
    valoreMax(MaxRighe),
    NuovaRiga is Riga+1,
    NuovaRiga =< MaxRighe,!.

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
    member(Posizione, ListaPosizioni),!. % evita di fare controlli con altre griglie quando ne trovo una(tanto so che è l'unica)

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
    (
        % Se esiste un fatto vuota(pos(Riga, Colonna), _)
        clause(vuota(pos(Riga, Colonna), _), _) -> 
        retract(vuota(pos(Riga, Colonna), _))        ;
        % Altrimenti, prosegui senza retract
        true
    ),
    assert(vuota(pos(Riga, Colonna), ValoreDaAssegnare)),
    NuovaColonna is Colonna + 1,
    valoreMax(MaxNColonne),
    NuovaColonna =< MaxNColonne,!.

% else: Prosegue senza applicare l'assegnamento (caso di fallimento)
trasforma(assegna(ValoreDaAssegnare),pos(Riga,Colonna),pos(NuovaRiga,NuovaColonna)):-
    % write("qui"),
    (
        % Se esiste un fatto vuota(pos(Riga, Colonna), _)
        clause(vuota(pos(Riga, Colonna), _), _) -> 
        retract(vuota(pos(Riga, Colonna), _))        ;
        % Altrimenti, prosegui senza retract
        true
    ),
    assert(vuota(pos(Riga, Colonna), ValoreDaAssegnare)),
    NuovaColonna is 1,
    NuovaRiga is Riga +1.
    
% Scorre l'esecuzione sulla prossima cella in riga
trasforma(scorriRiga,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    NuovaColonna is Colonna+1.

% Scorre l'esecuzione sulla prossima cella in colonna
trasforma(cambiaRiga,pos(Riga,Colonna),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is Riga+1,
    NuovaColonna is 1.