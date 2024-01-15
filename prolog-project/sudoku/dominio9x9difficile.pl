% DOMINIO SUDOKU 4x4
:- discontiguous vuota/2.
:- discontiguous piena/2.
:- dynamic vuota/2.
:- retractall(vuota(_, _)).  %per partire da uno stato pulito senza considerare i precedenti fatti asseriti

valoreMax(9).

listaPoxVal([1,2,3,4,5,6,7,8,9]).

iniziale(pos(1,1)).

% Prima riga
piena(pos(1,1),4).
vuota(pos(1,2),0).
vuota(pos(1,3),0).
vuota(pos(1,4),0).
vuota(pos(1,5),0).
vuota(pos(1,6),0).
vuota(pos(1,7),0).
piena(pos(1,8),9).
vuota(pos(1,9),0).

% Seconda riga
piena(pos(2,1),1).
vuota(pos(2,2),0).
vuota(pos(2,3),0).
vuota(pos(2,4),0).
vuota(pos(2,5),0).
vuota(pos(2,6),0).
piena(pos(2,7),5).
vuota(pos(2,8),0).
piena(pos(2,9),2).

% Terza riga
vuota(pos(3,1),0).
vuota(pos(3,2),0).
piena(pos(3,3),7).
piena(pos(3,4),9).
vuota(pos(3,5),0).
piena(pos(3,6),2).
vuota(pos(3,7),0).
piena(pos(3,8),1).
vuota(pos(3,9),0).

% Quarta riga
vuota(pos(4,1),0).
vuota(pos(4,2),0).
piena(pos(4,3),5).
piena(pos(4,4),2).
vuota(pos(4,5),0).
piena(pos(4,6),3).
vuota(pos(4,7),0).
vuota(pos(4,8),0).
vuota(pos(4,9),0).

% Quinta riga
vuota(pos(5,1),0).
vuota(pos(5,2),0).
vuota(pos(5,3),0).
vuota(pos(5,4),0).
vuota(pos(5,5),0).
vuota(pos(5,6),0).
vuota(pos(5,7),0).
piena(pos(5,8),8).
vuota(pos(5,9),0).

% Sesta riga
vuota(pos(6,1),0).
piena(pos(6,2),9).
vuota(pos(6,3),0).
piena(pos(6,4),1).
vuota(pos(6,5),0).
vuota(pos(6,6),0).
piena(pos(6,7),4).
vuota(pos(6,8),0).
piena(pos(6,9),5).

% Settima riga
piena(pos(7,1),8).
piena(pos(7,2),7).
vuota(pos(7,3),0).
vuota(pos(7,4),0).
vuota(pos(7,5),0).
vuota(pos(7,6),0).
vuota(pos(7,7),0).
vuota(pos(7,8),0).
piena(pos(7,9),3).

% Ottava riga
vuota(pos(8,1),0).
vuota(pos(8,2),0).
piena(pos(8,3),2).
vuota(pos(8,4),0).
vuota(pos(8,5),0).
vuota(pos(8,6),0).
piena(pos(8,7),7).
vuota(pos(8,8),0).
vuota(pos(8,9),0).

% Nona riga
vuota(pos(9,1),0).
piena(pos(9,2),3).
vuota(pos(9,3),0).
vuota(pos(9,4),0).
vuota(pos(9,5),0).
vuota(pos(9,6),0).
piena(pos(9,7),8).
piena(pos(9,8),5).
piena(pos(9,9),1).

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

finale:-
        % Prima riga
        vuota(pos(1,2),2),
        vuota(pos(1,3),3),
        vuota(pos(1,4),5),
        vuota(pos(1,5),1),
        vuota(pos(1,6),7),
        vuota(pos(1,7),6),
        vuota(pos(1,9),8),
        
        % Seconda riga
        vuota(pos(2,2),6),
        vuota(pos(2,3),9),
        vuota(pos(2,4),3),
        vuota(pos(2,5),4),
        vuota(pos(2,6),8),
        vuota(pos(2,8),7),
        
        % Terza riga
        vuota(pos(3,1),5),
        vuota(pos(3,2),8),
        vuota(pos(3,5),6),
        vuota(pos(3,7),3),
        vuota(pos(3,9),4),

        % Quarta riga
        vuota(pos(4,1),7),
        vuota(pos(4,2),4),
        vuota(pos(4,5),8),
        vuota(pos(4,7),1),
        vuota(pos(4,8),6),
        vuota(pos(4,9),9),
        
        % Quinta riga
        vuota(pos(5,1),3),
        vuota(pos(5,2),1),
        vuota(pos(5,3),6),
        vuota(pos(5,4),4),
        vuota(pos(5,5),9),
        vuota(pos(5,6),5),
        vuota(pos(5,7),2),
        vuota(pos(5,9),7),
        
        % Sesta riga
        vuota(pos(6,1),2),
        vuota(pos(6,3),8),
        vuota(pos(6,5),7),
        vuota(pos(6,6),6),
        vuota(pos(6,8),3),

        % Settima riga
        vuota(pos(7,3),1),
        vuota(pos(7,4),6),
        vuota(pos(7,5),5),
        vuota(pos(7,6),4),
        vuota(pos(7,7),9),
        vuota(pos(7,8),2),

        % Ottava riga
        vuota(pos(8,1),9),
        vuota(pos(8,2),5),
        vuota(pos(8,4),8),
        vuota(pos(8,5),3),
        vuota(pos(8,6),1),
        vuota(pos(8,8),4),
        vuota(pos(8,9),6),
        
        % Nona riga
        vuota(pos(9,1),6),
        vuota(pos(9,3),4),
        vuota(pos(9,4),7),
        vuota(pos(9,5),2),
        vuota(pos(9,6),9).
