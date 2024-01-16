% DOMINIO SUDOKU 4x4
:- discontiguous vuota/2.
:- discontiguous piena/2.
:- dynamic vuota/2.
:- retractall(vuota(_, _)).  %per partire da uno stato pulito senza considerare i precedenti fatti asseriti

valoreMax(4).

listaPoxVal([1,2,3,4]).

iniziale(pos(1,1)).

% Prima riga
vuota(pos(1,1),0).
piena(pos(1,2),1).
piena(pos(1,3),2).
piena(pos(1,4),4).

% Seconda riga
piena(pos(2,1),4).
vuota(pos(2,2),0).
vuota(pos(2,3),0).
piena(pos(2,4),1).

% Terza riga
piena(pos(3,1),2).
vuota(pos(3,2),0).
vuota(pos(3,3),0).
piena(pos(3,4),3).

% Quarta riga
piena(pos(4,1),1).
vuota(pos(4,2),0).
vuota(pos(4,3),0).
vuota(pos(4,4),0).

%% Aggiunta informazione sulle griglie

griglia(1,[pos(1,1),pos(1,2),pos(2,1),pos(2,2)]).
griglia(2,[pos(1,3),pos(1,4),pos(2,3),pos(2,4)]).
griglia(3,[pos(3,1),pos(3,2),pos(4,1),pos(4,2)]).
griglia(4,[pos(3,3),pos(3,4),pos(4,3),pos(4,4)]).


%% PREDICATO DI USCITA: 

finale:-
        vuota(pos(1,1),3),

        % Seconda riga
        vuota(pos(2,2),2),
        vuota(pos(2,3),3),

        % Terza riga
        vuota(pos(3,2),4),
        vuota(pos(3,3),1),

        % Quarta riga
        vuota(pos(4,2),3),
        vuota(pos(4,3),4),
        vuota(pos(4,4),2).
