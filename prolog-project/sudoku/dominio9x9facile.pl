% DOMINIO SUDOKU 4x4
:- discontiguous vuota/2.
:- discontiguous piena/2.
:- dynamic vuota/2.
:- retractall(vuota(_, _)).  %per partire da uno stato pulito senza considerare i precedenti fatti asseriti

valoreMax(9).
sommaValoriCelle(405).

listaPoxVal([1,2,3,4,5,6,7,8,9]).

iniziale(pos(1,1)).

% Prima riga
vuota(pos(1,1),0).
piena(pos(1,2),9).
piena(pos(1,3),1).
vuota(pos(1,4),0).
vuota(pos(1,5),0).
vuota(pos(1,6),0).
vuota(pos(1,7),0).
piena(pos(1,8),5).
piena(pos(1,9),3).

% Seconda riga
vuota(pos(2,1),0).
vuota(pos(2,2),0).
piena(pos(2,3),2).
vuota(pos(2,4),0).
piena(pos(2,5),3).
vuota(pos(2,6),0).
vuota(pos(2,7),0).
piena(pos(2,8),6).
vuota(pos(2,9),0).

% Terza riga
piena(pos(3,1),6).
vuota(pos(3,2),0).
piena(pos(3,3),3).
vuota(pos(3,4),0).
piena(pos(3,5),1).
vuota(pos(3,6),0).
piena(pos(3,7),7).
piena(pos(3,8),9).
piena(pos(3,9),2).

% Quarta riga
piena(pos(4,1),5).
piena(pos(4,2),7).
piena(pos(4,3),9).
piena(pos(4,4),4).
piena(pos(4,5),8).
piena(pos(4,6),2).
vuota(pos(4,7),0).
piena(pos(4,8),1).
piena(pos(4,9),6).

% Quinta riga
piena(pos(5,1),2).
piena(pos(5,2),1).
piena(pos(5,3),8).
vuota(pos(5,4),0).
piena(pos(5,5),9).
piena(pos(5,6),3).
piena(pos(5,7),5).
piena(pos(5,8),4).
piena(pos(5,9),7).

% Sesta riga
vuota(pos(6,1),0).
piena(pos(6,2),3).
piena(pos(6,3),6).
piena(pos(6,4),5).
piena(pos(6,5),7).
piena(pos(6,6),1).
piena(pos(6,7),2).
vuota(pos(6,8),0).
vuota(pos(6,9),0).

% Settima riga
piena(pos(7,1),9).
piena(pos(7,2),2).
piena(pos(7,3),4).
vuota(pos(7,4),0).
piena(pos(7,5),5).
piena(pos(7,6),8).
piena(pos(7,7),6).
vuota(pos(7,8),0).
piena(pos(7,9),1).

% Ottava riga
piena(pos(8,1),3).
piena(pos(8,2),8).
vuota(pos(8,3),0).
vuota(pos(8,4),0).
vuota(pos(8,5),0).
piena(pos(8,6),6).
piena(pos(8,7),9).
piena(pos(8,8),2).
piena(pos(8,9),5).

% Nona riga
vuota(pos(9,1),0).
vuota(pos(9,2),0).
vuota(pos(9,3),0).
vuota(pos(9,4),0).
piena(pos(9,5),2).
vuota(pos(9,6),0).
vuota(pos(9,7),0).
piena(pos(9,8),7).
piena(pos(9,9),8).

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

% finale:-
%         % Prima riga
%         vuota(pos(1,1),7),
%         vuota(pos(1,4),2),
%         vuota(pos(1,5),6),
%         vuota(pos(1,6),4),
%         vuota(pos(1,7),8),

%         % Seconda riga
%         vuota(pos(2,1),8),
%         vuota(pos(2,2),5),
%         vuota(pos(2,4),9),
%         vuota(pos(2,6),7),
%         vuota(pos(2,7),1),
%         vuota(pos(2,9),4),

%         % Terza riga
%         vuota(pos(3,2),4),
%         vuota(pos(3,4),8),
%         vuota(pos(3,6),5),

%         % Quarta riga
%         vuota(pos(4,7),3),

%         % Quinta riga
%         vuota(pos(5,4),6),

%         % Sesta riga
%         vuota(pos(6,1),4),
%         vuota(pos(6,8),8),
%         vuota(pos(6,9),9),

%         % Settima riga
%         vuota(pos(7,4),7),
%         vuota(pos(7,8),3),

%         % Ottava riga
%         vuota(pos(8,3),7),
%         vuota(pos(8,4),1),
%         vuota(pos(8,5),4),

%         % Nona riga
%         vuota(pos(9,1),1),
%         vuota(pos(9,2),6),
%         vuota(pos(9,3),5),
%         vuota(pos(9,4),3),
%         vuota(pos(9,6),9),
%         vuota(pos(9,7),4).

finale:-
        findall(Valore, piena(pos(_,_),Valore); vuota(pos(_,_),Valore), ListaValoriP),
        sommaLista(ListaValoriP,SommaP),
        sommaValoriCelle(SVC),
        SommaP is SVC.

sommaLista([],0).
sommaLista([H|Tail],SommaN):-
    sommaLista(Tail,Somma),
    SommaN is Somma+H.