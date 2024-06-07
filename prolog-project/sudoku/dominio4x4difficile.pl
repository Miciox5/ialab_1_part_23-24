% DOMINIO SUDOKU 4x4 difficile
:- discontiguous vuota/2.
:- discontiguous piena/2.
:- dynamic vuota/2.
:- retractall(vuota(_, _)).  %per partire da uno stato pulito senza considerare i precedenti fatti asseriti

valoreMax(4).
sommaValoriCelle(40).

listaPoxVal([1,2,3,4]).

iniziale(pos(1,1)).

% Prima riga
vuota(pos(1,1),0).
piena(pos(1,2),3).
vuota(pos(1,3),0).
vuota(pos(1,4),0).

% Seconda riga
vuota(pos(2,1),0).
vuota(pos(2,2),0).
vuota(pos(2,3),0).
piena(pos(2,4),4).

% Terza riga
vuota(pos(3,1),0).
vuota(pos(3,2),0).
vuota(pos(3,3),0).
vuota(pos(3,4),0).

% Quarta riga
piena(pos(4,1),1).
vuota(pos(4,2),0).
piena(pos(4,3),2).
vuota(pos(4,4),0).

%% Aggiunta informazione sulle griglie

griglia(1,[pos(1,1),pos(1,2),pos(2,1),pos(2,2)]).
griglia(2,[pos(1,3),pos(1,4),pos(2,3),pos(2,4)]).
griglia(3,[pos(3,1),pos(3,2),pos(4,1),pos(4,2)]).
griglia(4,[pos(3,3),pos(3,4),pos(4,3),pos(4,4)]).


%% PREDICATO DI USCITA: 

finale:-
        findall(Valore, piena(pos(_,_),Valore); vuota(pos(_,_),Valore), ListaValoriP),
        sommaLista(ListaValoriP,SommaP),
        sommaValoriCelle(SVC),
        SommaP is SVC.

sommaLista([],0).
sommaLista([H|Tail],SommaN):-
    sommaLista(Tail,Somma),
    SommaN is Somma+H.