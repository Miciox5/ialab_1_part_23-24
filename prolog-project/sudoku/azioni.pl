%% FUNZIONI applicabile()

applicabile(assegna,pos(Riga,Colonna)):-
    inRange(pos(Riga,Colonna)),
    \+cella(pos(Riga,Colonna),ValoreCella),
    write("Casella vuota in posizione("),write(Riga),write(":"),write(Colonna).

applicabile(scorri,pos(Riga,Colonna)):-
    inRange(pos(Riga,Colonna)).    

applicabile(scorriRiga,pos(Riga,Colonna)):-
    num_righe(MaxRighe),
    Riga < MaxRighe,
    num_colonne(MaxColonne),
    Colonna == MaxColonne.

% TO-DO: definire il caso base delle azioni di uscita
% applicabile(finito,pos(Riga,Colonna)):
%     num_colonne(MaxColonne),
%     num_righe(MaxRighe),
%     Riga == MaxRighe,
%     Colonna == MaxColonne.

applicabile(ricomincia,pos(Riga,Colonna)):-
    num_colonne(MaxColonne),
    num_righe(MaxRighe),
    Riga == MaxRighe,
    Colonna == MaxColonne.
    
%% PREDICATI AUSILIARI

% Verifica se la posizione passata si trova nel sudoku
inRange(pos(RigaAttuale,ColonnaAttuale)):-
    num_colonne(MaxColonne),
    num_righe(MaxRighe),
    RigaAttuale =< MaxRighe,!,
    ColonnaAttuale =< MaxColonne,!.

%% FUNZIONI trasforma()

% parameter: assegna
%   La funzione ha il compito di assegnare ad una casella vuota un valore
%   secondo la strategia di ricerca.
trasforma(assegna,pos(Riga,Colonna),pos(NuovaRiga,NuovaColonna)):-
    cella(pos(Riga,Colonna),ValoreVuoto),
    NuovaRiga is Riga+1,
    NuovaColonna is Colonna,
    write(ValoreVuoto).

% parameter: scorri
%   La funzione ha il compito di scorrere la posizione della colonna, 
%   aggiornato lo stato attuale.
trasforma(scorri,pos(Riga,Colonna),pos(NuovaRiga,NuovaColonna)):-
    NuovaColonna is Colonna+1,
    inRange(pos(Riga,NuovaColonna)),
    NuovaRiga is Riga.

% parameter: scorriRiga
%   La funzione ha il compito di scorrere la posizione della riga dopo
%   averla esaminata, aggiornando lo stato.
trasforma(scorriRiga,pos(Riga,Colonna),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is Riga+1,
    inRange(pos(NuovaRiga,Colonna)),
    NuovaColonna is 1.

% parameter: ricomincia
%   La funzione ha il compito di riposizionare il solver sullo stato 
%   iniziale se non si è ancora trovata una soluzione
trasforma(ricomincia,pos(_,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is 1,
    NuovaColonna is 1.