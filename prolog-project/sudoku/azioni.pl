:- dynamic cella/2.  %per modificare dinamicamente la base di conoscenza durante l'esecuzione

%% FUNZIONI applicabile()

applicabile(ricomincia,pos(Riga,Colonna)):-
    num_righe(MaxRighe),
    Riga==MaxRighe,
    num_colonne(MaxColonne),
    Colonna > MaxColonne,
    nl,write('---Entra in ricomincia---'),nl,nl.

applicabile(assegna,pos(Riga,Colonna)):-
    num_righe(MaxRighe),
    Riga =< MaxRighe,
    num_colonne(MaxColonne),
    Colonna =< MaxColonne,
    \+cella(pos(Riga,Colonna),_),
    write('Casella vuota in posizione -> ('),write(Riga),write(':'),write(Colonna),write(')'),nl.

applicabile(scorriRiga,pos(_,Colonna)):-
    num_colonne(MaxColonne),
    NuovaColonna is Colonna+1,
    NuovaColonna =< MaxColonne.
 
applicabile(cambiaRiga,pos(Riga,_)):-
    num_righe(MaxRighe),
    NuovaRiga is Riga+1,
    NuovaRiga =< MaxRighe.


%% FUNZIONI trasforma()

% parameter: ricomincia
%   La funzione ha il compito di riposizionare il solver sullo stato 
%   iniziale se non si è ancora trovata una soluzione
trasforma(ricomincia,pos(_,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is 1,
    NuovaColonna is 1.

% parameter: assegna
%   La funzione ha il compito di assegnare ad una casella vuota un valore
%   secondo la strategia di ricerca.

% trasforma(assegna,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
%     listaInEsame(L),
%     nth1(Prove, L, UnicoValore),
%     write('Assegnamento: '),write(UnicoValore),nl,
%     assert(cella(pos(Riga, Colonna),UnicoValore)),
%     numeroCelle(F),
%     R is F+1,
%     retract(numeroCelle(F)),
%     assert(numeroCelle(R)),
%     NuovaColonna is Colonna+1.

trasforma(assegna,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    listaPossibili(LP),
    ricercaValoriPossibili(cella(pos(Riga,Colonna)),LP,NewListaPossibili),
    % Assegnamento one shot
    % --------
    length(NewListaPossibili, NPossibili),
    NPossibili >0,
    NPossibili ==1,
    nth1(1,NewListaPossibili,ValoreDaAssegnare),
    write('Assegnamento: '),write(ValoreDaAssegnare),nl,
    assert(cella(pos(Riga,Colonna),ValoreDaAssegnare)),
    % --------
    numeroCelle(NC),
    UpdateNC is NC+1,
    retract(numeroCelle(_)),
    assert(numeroCelle(UpdateNC)),
    NuovaColonna is Colonna+1.

% trasforma(assegna,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
%     listaPossibili(LP),
%     ricercaValoriPossibili(cella(pos(Riga,Colonna)),LP,NewListaPossibili),
%     % Assegnamento one shot
%     % --------
%     length(NewListaPossibili, NPossibili),
%     NPossibili >0,
%     between(1, 2, NPossibili),
%     nth1(Soluzione,NewListaPossibili,ValoreDaAssegnare),
%     % assert(cella(pos(Riga,Colonna),ValoreDaAssegnare)),
%     % --------
%     numeroCelle(NC),
%     UpdateNC is NC+1,
%     retract(numeroCelle(_)),
%     assert(numeroCelle(UpdateNC)),
%     NuovaColonna is Colonna+1.

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

%% PREDICATI AUSILIARI

% Ricerca di un VALORE SICURO da assegnare

ricercaValoriPossibili(cella(pos(Riga,Colonna)),ListaPossibili,NewListaPossibili):-
    controlloRiga(Riga,ListaPossibili,LPRighe),
    controlloColonna(Colonna,LPRighe,LPColonne),
    controlloGriglia(Riga,Colonna,LPColonne,NewListaPossibili),
    write('Lista valori possibili: '),write(NewListaPossibili),nl.

% Ricerca nella RIGA

controlloRiga(Riga,Iniziale,Finale):-
    findall(Valore, cella(pos(Riga, _), Valore), Valori),
    subtract(Iniziale, Valori, Finale).

% Ricerca nella COLONNA

controlloColonna(Colonna,Iniziale, Finale):-
    findall(Valore, cella(pos(_, Colonna), Valore), Valori),
    subtract(Iniziale, Valori, Finale).

% Ricerca nella GRIGLIA

controlloGriglia(Riga, Colonna,Iniziale, Finale):-
    trovaNumeriGriglia(pos(Riga,Colonna),NumeroGriglia, ValoriInGriglia),
    subtract(Iniziale, ValoriInGriglia,Finale).

trovaNumeriGriglia(Posizione,NumeroGriglia, ValoriInGriglia):-
    griglia(NumeroGriglia, ListaPosizioni),
    member(Posizione, ListaPosizioni),!,
    prendiValoriInGriglia(ListaPosizioni, ValoriInGriglia),!.

prendiValoriInGriglia([], []).
prendiValoriInGriglia([Posizione|RestoPosizioni], ValoriInGriglia):-
    findall(Valore, cella(Posizione, Valore), Valori),
    append(Valori, RestoValoriInGriglia, ValoriInGriglia),
    prendiValoriInGriglia(RestoPosizioni, RestoValoriInGriglia).
