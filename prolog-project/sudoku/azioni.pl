:- dynamic cella/2.  %per modificare dinamicamente la base di conoscenza durante l'esecuzione

%% FUNZIONI applicabile()

applicabile(ricomincia,pos(Riga,Colonna)):-
    num_righe(MaxRighe),
    Riga==MaxRighe,
    num_colonne(MaxColonne),
    NuovaColonna is Colonna+1,
    NuovaColonna>MaxColonne.
    
applicabile(assegna(ValoreDaAssegnare),pos(Riga,Colonna)):-
    \+cella(pos(Riga,Colonna),_),
    write("Casella vuota in posizione("),write(Riga),write(":"),write(Colonna)),
    valoreSicuro(cella(pos(Riga,Colonna),ValoreDaAssegnare)).

applicabile(scorriRiga,pos(_,Colonna)):-
    num_colonne(MaxColonne),
    NuovaColonna is Colonna+1,
    NuovaColonna =< MaxColonne.
 
applicabile(cambiaRiga,pos(Riga,_)):-
    num_righe(MaxRighe),
    NuovaRiga is Riga+1,
    NuovaRiga =< MaxRighe.

% TO-DO: definire il caso base delle azioni di uscita  ??????????????????????????
% applicabile(finito,pos(Riga,Colonna)):   
%     num_colonne(MaxColonne),
%     num_righe(MaxRighe),
%     Riga == MaxRighe,
%     Colonna == MaxColonne.

 
%% PREDICATI AUSILIARI

% Ricerca di un VALORE SICURO da assegnare

valoreSicuro(cella(pos(Riga,Colonna),ValoreDaAssegnare)):-
    mancaSoloUnNumeroRiga(Riga,ValoreDaAssegnare).

valoreSicuro(cella(pos(Riga,Colonna),ValoreDaAssegnare)):-
    mancaSoloUnNumeroColonna(Colonna,ValoreDaAssegnare).    
    
valoreSicuro(cella(pos(Riga,Colonna),ValoreDaAssegnare)):-
    mancaSoloUnNumeroGriglia(Riga,Colonna,ValoreDaAssegnare).

% Ricerca nella RIGA

mancaSoloUnNumeroRiga(Riga,ValoreDaAssegnare):-
    contaNumeriRiga(Riga,Valori),
    length(Valori, Ris),
    write(Ris),
    num_righe(MaxRighe),
    NuovoRis is Ris+1,
    NuovoRis == MaxRighe,
    assegnaNumeroMancanteRiga(Riga, Valori, ValoreDaAssegnare).

contaNumeriRiga(Riga,Valori):-
    findall(Valore, cella(pos(Riga, _), Valore), Valori).

assegnaNumeroMancanteRiga(Riga, Valori, ValoreDaAssegnare):-
    valoreMaxPossibile(Max),
    between(1, Max, Numero),  % Prova con ogni numero possibile nella colonna
    \+ member(Numero, Valori),      % Verifica se il numero non è presente nella colonna
    write("Assegna numero "), write(Numero),
    ValoreDaAssegnare is Numero.

% Ricerca nella COLONNA

mancaSoloUnNumeroColonna(Colonna, ValoreDaAssegnare):-
    contaNumeriColonna(Colonna, Valori),
    length(Valori, Ris),
    write(Ris),
    num_righe(MaxRighe),
    NuovoRis is Ris + 1,
    NuovoRis == MaxRighe,
    assegnaNumeroMancanteColonna(Colonna, Valori, ValoreDaAssegnare).

contaNumeriColonna(Colonna, Valori):-
    findall(Valore, cella(pos(_, Colonna), Valore), Valori).

assegnaNumeroMancanteColonna(Colonna, Valori, ValoreDaAssegnare):-
    valoreMaxPossibile(Max),
    between(1, Max, Numero),  % Prova con ogni numero possibile nella colonna
    \+ member(Numero, Valori),      % Verifica se il numero non è presente nella colonna
    write("Assegna numero "), write(Numero),
    ValoreDaAssegnare is Numero.


% Ricerca nella GRIGLIA

mancaSoloUnNumeroGriglia(Riga, Colonna, ValoreDaAssegnare):-
    trovaGriglia(pos(Riga,Colonna), NumeroGriglia),
    contaNumeriGriglia(NumeroGriglia, ValoriInGriglia),
    length(ValoriInGriglia,NValoriInGriglia),
    Ris is NValoriInGriglia+1,
    valoreMaxPossibile(Max),
    Ris == Max,
    assegnaNumeroMancanteGriglia(ValoriInGriglia,ValoreDaAssegnare).

trovaGriglia(Posizione, NumeroGriglia) :-
    clause(griglia(NumeroGriglia, ListaPosizioni), _).

contaNumeriGriglia(NumeroGriglia, ValoriInGriglia):-
    griglia(NumeroGriglia, ListaPosizioni),
    prendiValoriInGriglia(ListaPosizioni, ValoriInGriglia).
    % length(ValoriInGriglia,NValoriInGriglia),
    % Ris is NValoriInGriglia+1,
    % valoreMaxPossibile(Max),
    % Ris == Max,
    % assegnaNumeroMancanteGriglia(ValoriInGriglia,ValoreDaAssegnare).

prendiValoriInGriglia([], []).
prendiValoriInGriglia([Posizione|RestoPosizioni], ValoriInGriglia):-
    findall(Valore, cella(Posizione, Valore), Valori),
    append(Valori, RestoValoriInGriglia, ValoriInGriglia),
    prendiValoriInGriglia(RestoPosizioni, RestoValoriInGriglia).

assegnaNumeroMancanteGriglia(ValoriInGriglia,ValoreDaAssegnare):-
    valoreMaxPossibile(Max),
    between(1, Max, Numero),  % Prova con ogni numero possibile nella colonna
    \+ member(Numero, ValoriInGriglia),      % Verifica se il numero non è presente nella colonna
    write("Assegna numero "), write(Numero),
    ValoreDaAssegnare is Numero.

%% FUNZIONI trasforma()

% parameter: assegna
%   La funzione ha il compito di assegnare ad una casella vuota un valore
%   secondo la strategia di ricerca.

% trasforma(assegna,pos(Riga,Colonna),pos(NuovaRiga,NuovaColonna)):-
%     cella(pos(Riga,Colonna),ValoreVuoto),
%     NuovaRiga is Riga+1,
%     NuovaColonna is Colonna,
%     write(ValoreVuoto).

trasforma(assegna(ValoreDaAssegnare),pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    assert(cella(pos(Riga, Colonna), ValoreDaAssegnare)),
    NuovaColonna is Colonna+1.

% parameter: scorri
%   La funzione ha il compito di scorrere la posizione della colonna, 
%   aggiornato lo stato attuale.
trasforma(scorriRiga,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    NuovaColonna is Colonna+1.
    %inRange(pos(Riga,NuovaColonna)).
    %NuovaRiga is Riga.

% parameter: scorriRiga
%   La funzione ha il compito di scorrere la posizione della riga dopo
%   averla esaminata, aggiornando lo stato.
trasforma(cambiaRiga,pos(Riga,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is Riga+1,
    %inRange(pos(NuovaRiga,Colonna)),
    NuovaColonna is 1.

% parameter: ricomincia
%   La funzione ha il compito di riposizionare il solver sullo stato 
%   iniziale se non si è ancora trovata una soluzione
trasforma(ricomincia,pos(_,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is 1,
    NuovaColonna is 1.