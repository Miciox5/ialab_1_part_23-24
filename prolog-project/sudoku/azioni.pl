%applicabile(Azione,Stato(sudoku))
%predicato built-in per accedere agli elementi di una lista tramite l'indice.
applicabile(assegna, Sudoku) :-
    pos(Riga,Colonna),
    nth1(Riga, Sudoku, RigaCorrente),
    nth1(Colonna, RigaCorrente, ValoreCella), %per prendere il valore prendo la colonna della riga
    ValoreCella == 0.
    %bestCella()

% bestCella :- 
%     checkvincoli righe
%     checkvincoli colonne
%     check griglia
%     check solo 1 possibilita

applicabile(scorriRiga, _) :-
    pos(Riga,Colonna),
    num_colonne(NMaxColonne),
    % LimiteColonne is NMaxColonne+1,
    NuovaColonna is Colonna+1,
    \+outOfRange(NuovaColonna,NMaxColonne),
    % LimiteColonne\==NuovaColonna, 

    %non sono da fare in trasforma?? 
    retractall(pos(_,_)),
    assert(pos(Riga,NuovaColonna)).

applicabile(cambioRiga,_):-
    pos(Riga,Colonna),
    num_righe(NMaxRighe),
    % LimiteRighe is NMaxRighe+1,
    NuovaRiga is Riga+1,
    \+outOfRange(NuovaRiga,NMaxRighe),
    % LimiteRighe\==NuovaRiga,


    %non sono da fare in trasforma?? 
    retractall(pos(_,_)),
    assert(pos(NuovaRiga,Colonna)).

applicabile(daCapo,_) :-
    
    
    retractall(pos(_,_)),
    assert(pos(1,1)).


% Funzione di controllo sul limite del sudoku
outOfRange(Elem,Bound):-
    Bound < Elem.


%trasforma(Azione,Stato(sudoku),NuovoStato)
trasforma(assegna,Sudoku,NuovoSudoku),
    pos(Riga,Colonna),
    nth1(Riga, SudokuPrecedente, RigaCorrente),
    nth1(Colonna,RigaCorrente,ValoreCella).
    %sostituzione elemento lista