% DOMINIO SUDOKU 9x9

:- retractall(cella(_, _)).  %per partire da uno stato pulito senza considerare i precedenti fatti asseriti

num_colonne(9).
num_righe(9).
num_griglie(9).

valoreMaxPossibile(9).

:- dynamic listaInEsame/1.
:- dynamic numeroCelle/1.

listaPossibili([1,2,3,4,5,6,7,8,9]).

listaInEsame([1,2,3,4,5,6,7,8,9]).

iniziale(pos(1,1)).

numeroCelle(51).

% I fatti commentati (mancanti nella KB) indicano le caselle vuote.

% Prima riga
cella(pos(1,2),9).
cella(pos(1,3),1).
cella(pos(1,8),5).
cella(pos(1,9),3).
% Seconda riga
cella(pos(2,3),2).
cella(pos(2,5),3).
cella(pos(2,8),6).
% Terza riga
cella(pos(3,1),6).
cella(pos(3,3),3).
cella(pos(3,5),1).
cella(pos(3,7),7).
cella(pos(3,8),9).
cella(pos(3,9),2).

% Quarta riga
cella(pos(4,1),5).
cella(pos(4,2),7).
cella(pos(4,3),9).
cella(pos(4,4),4).
cella(pos(4,5),8).
cella(pos(4,6),2).
cella(pos(4,8),1).
cella(pos(4,9),6).
% Quinta riga
cella(pos(5,1),2).
cella(pos(5,2),1).
cella(pos(5,3),8).
cella(pos(5,5),9).
cella(pos(5,6),3).
cella(pos(5,7),5).
cella(pos(5,8),4).
cella(pos(5,9),7).
% Sesta riga
cella(pos(6,2),3).
cella(pos(6,3),6).
cella(pos(6,4),5).
cella(pos(6,5),7).
cella(pos(6,6),1).
cella(pos(6,7),2).

% Settima riga
cella(pos(7,1),9).
cella(pos(7,2),2).
cella(pos(7,3),4).
cella(pos(7,5),5).
cella(pos(7,6),8).
cella(pos(7,7),6).
cella(pos(7,9),1).
% Ottava riga
cella(pos(8,1),3).
cella(pos(8,2),8).
cella(pos(8,6),6).
cella(pos(8,7),9).
cella(pos(8,8),2).
cella(pos(8,9),5).
% Nona riga
cella(pos(9,5),2).
cella(pos(9,8),7).
cella(pos(9,9),8).

%% Aggiunta informazione sulle griglie

griglia(1,[pos(1,1),pos(1,2),pos(1,3),
           pos(2,1),pos(2,2),pos(2,3),
           pos(3,1),pos(3,2),pos(3,3)]).
griglia(2,[pos(1,4),pos(1,5),pos(1,6),
           pos(2,4),pos(2,5),pos(2,6),
           pos(3,4),pos(3,5),pos(3,6)]).
griglia(3,[pos(1,7),pos(1,8),pos(1,9),
           pos(2,7),pos(2,8),pos(2,9),
           pos(3,7),pos(3,8),pos(3,9)]).

griglia(4,[pos(4,1),pos(4,2),pos(4,3),
           pos(5,1),pos(5,2),pos(5,3),
           pos(6,1),pos(6,2),pos(6,3)]).
griglia(5,[pos(4,4),pos(4,5),pos(4,6),
           pos(5,4),pos(5,5),pos(5,6),
           pos(6,4),pos(6,5),pos(6,6)]).
griglia(6,[pos(4,7),pos(4,8),pos(4,9),
           pos(5,7),pos(5,8),pos(5,9),
           pos(6,7),pos(6,8),pos(6,9)]).

griglia(7,[pos(7,1),pos(7,2),pos(7,3),
           pos(8,1),pos(8,2),pos(8,3),
           pos(9,1),pos(9,2),pos(9,3)]).
griglia(8,[pos(7,4),pos(7,5),pos(7,6),
           pos(8,4),pos(8,5),pos(8,6),
           pos(9,4),pos(9,5),pos(9,6)]).
griglia(9,[pos(7,7),pos(7,8),pos(7,9),
           pos(8,7),pos(8,8),pos(8,9),
           pos(9,7),pos(9,8),pos(9,9)]).
%% PREDICATO DI USCITA: 
%    Il predicato di uscita controlla se i fatti mancanti (caselle vuote 
%    e poi riempite) sono stati definiti nella KB.
finale:-
    numeroCelle(X),
    X== 81.