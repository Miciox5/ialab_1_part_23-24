num_colonne(4).
num_righe(4).
num_griglie(4).

:- dynamic pos/2.
pos(1,1).

valori([1,2,3,4]).

griglia1([0,1,4,2]).
griglia2([0,4,0,1]).
griglia3([2,0,1,0]).
griglia4([0,3,0,0]).

iniziale([[0,1,0,4],
          [4,2,0,1],
          [2,0,0,3],
          [1,0,0,0]
        ]).

% soluzione(Sudoku):-
finale([[3,1,2,4],
        [4,2,3,1],
        [2,4,1,3],
        [1,3,4,2]
        ]).

