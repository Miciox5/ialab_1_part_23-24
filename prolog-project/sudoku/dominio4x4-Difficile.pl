% DOMINIO SUDOKU 4x4

:- retractall(cella(_, _)).  %per partire da uno stato pulito senza considerare i precedenti fatti asseriti

num_colonne(4).
num_righe(4).
num_griglie(4).

valoreMaxPossibile(4).

:- dynamic listaInEsame/1.
:- dynamic numeroCelle/1.

listaPossibili([1,2,3,4]).

listaInEsame([1,2,3,4]).

iniziale(pos(1,1)).

numeroCelle(5).

% I fatti commentati (mancanti nella KB) indicano le caselle vuote.

% Prima riga


% Seconda riga
cella(pos(2,2),2).
cella(pos(2,3),4).
cella(pos(2,4),1).

% Terza riga
cella(pos(3,1),4).
cella(pos(3,3),3).

% Quarta riga

%% Aggiunta informazione sulle griglie

griglia(1,[pos(1,1),pos(1,2),pos(2,1),pos(2,2)]).
griglia(2,[pos(1,3),pos(1,4),pos(2,3),pos(2,4)]).
griglia(3,[pos(3,1),pos(3,2),pos(4,1),pos(4,2)]).
griglia(4,[pos(3,3),pos(3,4),pos(4,3),pos(4,4)]).

%% PREDICATO DI USCITA: 
%    Il predicato di uscita controlla se i fatti mancanti (caselle vuote 
%    e poi riempite) sono stati definiti nella KB.
finale:-
    numeroCelle(N),
    N == 16.
    % % Prima riga
    % cella(pos(1,1),3),
    % cella(pos(1,3),2),

    % % Seconda riga
    % %cella(pos(2,2),2),
    % cella(pos(2,3),3),

    % % Terza riga
    % cella(pos(3,2),4),
    % cella(pos(3,3),1),

    % % Quarta riga
    % cella(pos(4,2),3),
    % cella(pos(4,3),4),
    % cella(pos(4,4),2).
