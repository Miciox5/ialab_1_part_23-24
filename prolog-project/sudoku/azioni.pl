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


% applicabile(scorriRiga, Sudoku) :-
%     pos(Riga,Colonna),
%     num_colonne(NMaxColonne),
%     NuovaColonna is Colonna+1,
%     \+outOfRange(NuovaColonna,NMaxColonne),
%     retractall(pos(_,_)),
%     assert(pos(Riga,NuovaColonna)).


% applicabile(cambioRiga,Sudoku):-
%     pos(Riga,Colonna),
%     num_righe(NMaxRighe),
%     NuovaRiga is Riga+1,
%     \+outOfRange(NuovaRiga,NMaxRighe),
%     retractall(pos(_,_)),
%     assert(pos(NuovaRiga,Colonna)).

% outOfRange(Elem,Bound):-
%     Bound < Elem.


applicabile(scorriRiga, _) :-
    pos(Riga,Colonna),
    num_colonne(NMaxColonne),
    LimiteColonne is NMaxColonne+1,
    NuovaColonna is Colonna+1,
    LimiteColonne\==NuovaColonna, 

    %non sono da fare in trasforma?? 
    retractall(pos(_,_)),
    assert(pos(Riga,NuovaColonna)).

applicabile(cambioRiga,_):-
    pos(Riga,Colonna),
    num_righe(NMaxRighe),
    LimiteRighe is NMaxRighe+1,
    NuovaRiga is Riga+1,
    LimiteRighe\==NuovaRiga,


    retractall(pos(_,_)),
    assert(pos(NuovaRiga,Colonna)).

applicabile(daCapo,_) :-
    
    
    retractall(pos(_,_)),
    assert(pos(1,1)).




%trasforma(Azione,Stato(sudoku),NuovoStato)
trasforma(assegna,Sudoku,NuovoSudoku),
    pos(Riga,Colonna),
    nth1(Riga, SudokuPrecedente, RigaCorrente),
    nth1(Colonna,RigaCorrente,ValoreCella).
    %sostituzione elemento lista