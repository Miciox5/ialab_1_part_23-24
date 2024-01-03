% Libreria per aritmetica dichiarativa interi
%   https://www.swi-prolog.org/pldoc/man?section=clpfd-integer-arith
% use_module(library(clpfd)).

% applicabile():-

%predicato built-in per accedere agli elementi di una lista tramite l'indice.
applicabile(assegna, Sudoku) :-
    pos(Riga,Colonna),
    nth1(Riga, Sudoku, RigaCorrente),
    nth1(Colonna, RigaCorrente, ValoreCella), %per prendere il valore prendo la colonna della riga
    ValoreCella == 0.
    bestCella()

bestCella :- 
    checkvincoli righe
    checkvincoli colonne
    check griglia
    check solo 1 possibilità

applicabile(scorriRiga, Sudoku) :-
    pos(Riga,Colonna),
    num_colonne(NMaxColonne),
    LimiteColonne is NMaxColonne+1,
    NuovaColonna is Colonna+1,
    LimiteColonne\==NuovaColonna,  
    retractall(pos(_,_)),
    assert(pos(Riga,NuovaColonna)).

applicabile(cambioRiga,Sudoku):-
    pos(Riga,Colonna),
    num_righe(NMaxRighe),
    LimiteRighe is NMaxRighe+1,
    NuovaRiga is Riga+1,
    LimiteRighe\==NuovaRiga,
    retractall(pos(_,_)),
    assert(pos(NuovaRiga,Colonna)).



% applicabile(1,[SingoloValore|_]):-
%     % Vedere se la cella è vuota
%     write(SingoloValore).
%     % SingoloValore <1.
%     % Condizione di start
%     % condizioneStart([Riga|RestoSudoku]),

%     % Continuare la ricerca o spostarsi avanti.
%     % applicabile(Riga).

% applicabile(2,[])

% Controlla se la cella è da riempire. Cella vuota -> valore 0


% TO-DO: Prende la colonna della cella in esame

% TO-DO: Prende la griglia della cella in esame

% Controlla se la somma dei valori nelle 
%   righe/colonne/griglie rispettano i vincoli. 
% sommaCelle([],0).
% sommaCelle([H|T],Somma):-
%     % all_distinct([N1,N2,N3,N4]),
%     sommaCelle(T,TSomma),
%     Somma is H + TSomma.
% sommaCelleOk(SommaCelle):-
%     SommaCelle = 10.

% TO-DO: Condizione di start di una cella
% condizioneStart([Riga|RestoSudoku]):-


% trasforma():-
% trasforma(Snuovo):-
%     0==0.

