:- dynamic cella/2.  %per modificare dinamicamente la base di conoscenza durante l'esecuzione

%% FUNZIONI applicabile()

applicabile(ricomincia,pos(Riga,Colonna)):-
    num_righe(MaxRighe),
    Riga==MaxRighe,
    num_colonne(MaxColonne),
    Colonna>MaxColonne.
    
applicabile(assegna,pos(Riga,Colonna)):-
    \+cella(pos(Riga,Colonna),_),
    write('Casella vuota in posizione -> ('),write(Riga),write(':'),write(Colonna),write(')'),nl,
    listaPossibili(LP),
    retract(listaInEsame(L)),
    assert(listaInEsame(LP)),
    valoreSicuro(cella(pos(Riga,Colonna))).

applicabile(scorriRiga,pos(_,Colonna)):-
    num_colonne(MaxColonne),
    NuovaColonna is Colonna+1,
    NuovaColonna =< MaxColonne.
 
applicabile(cambiaRiga,pos(Riga,_)):-
    num_righe(MaxRighe),
    NuovaRiga is Riga+1,
    NuovaRiga =< MaxRighe.
 
%% PREDICATI AUSILIARI

% Ricerca di un VALORE SICURO da assegnare

valoreSicuro(cella(pos(Riga,Colonna))):-
    controlloRiga(Riga),
    listaInEsame(L),
    length(L, NPossibili),
    NPossibili == 1.

valoreSicuro(cella(pos(Riga,Colonna))):-
    controlloColonna(Colonna),
    listaInEsame(L),
    length(L, NPossibili),
    NPossibili == 1.
    
valoreSicuro(cella(pos(Riga,Colonna))):-
    controlloGriglia(Riga,Colonna),
    listaInEsame(L),
    write('Lista valori possibili: '),write(L),nl,
    length(L, NPossibili),
    NPossibili == 1.

% Ricerca nella RIGA

controlloRiga(Riga):-
    findall(Valore, cella(pos(Riga, _), Valore), Valori),
    listaInEsame(ListaInEsame),
    subtract(ListaInEsame, Valori, Sottrazione),
    %write(Sottrazione), nl,
    retract(listaInEsame(ListaInEsame)),
    assert(listaInEsame(Sottrazione)).

% Ricerca nella COLONNA

controlloColonna(Colonna):-
    findall(Valore, cella(pos(_, Colonna), Valore), Valori),
    length(Valori, Ris),
    listaInEsame(ListaInEsame),
    subtract(ListaInEsame, Valori, Sottrazione),
    %write(Sottrazione), nl,
    retract(listaInEsame(L)),
    assert(listaInEsame(Sottrazione)).


% Ricerca nella GRIGLIA

controlloGriglia(Riga, Colonna):-
    trovaGriglia(pos(Riga,Colonna), NumeroGriglia),
    trovaNumeriGriglia(NumeroGriglia, ValoriInGriglia),
    listaInEsame(ListaInEsame),
    subtract(ListaInEsame, ValoriInGriglia, Sottrazione),
    %write(Sottrazione), nl,
    retract(listaInEsame(L)),
    assert(listaInEsame(Sottrazione)).

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
    findall(Valore, cella(Posizione, Valore), Valori),
    append(Valori, RestoValoriInGriglia, ValoriInGriglia),
    prendiValoriInGriglia(RestoPosizioni, RestoValoriInGriglia).

%% FUNZIONI trasforma()

% parameter: assegna
%   La funzione ha il compito di assegnare ad una casella vuota un valore
%   secondo la strategia di ricerca.

trasforma(assegna,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    listaInEsame(L),
    nth1(1, L, UnicoValore),
    write('Assegnamento: '),write(UnicoValore),nl,
    assert(cella(pos(Riga, Colonna),UnicoValore)),!,
    NuovaColonna is Colonna+1.

% parameter: scorri
%   La funzione ha il compito di scorrere la posizione della colonna, 
%   aggiornato lo stato attuale.
trasforma(scorriRiga,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    NuovaColonna is Colonna+1.


% parameter: scorriRiga
%   La funzione ha il compito di scorrere la posizione della riga dopo
%   averla esaminata, aggiornando lo stato.
trasforma(cambiaRiga,pos(Riga,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is Riga+1,
    NuovaColonna is 1.

% parameter: ricomincia
%   La funzione ha il compito di riposizionare il solver sullo stato 
%   iniziale se non si è ancora trovata una soluzione
trasforma(ricomincia,pos(_,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is 1,
    NuovaColonna is 1.