% DOMINIO SUDOKU 2x2

:- retractall(cella(_, _)).  %per partire da uno stato pulito senza considerare i precedenti fatti asseriti
%   Implementazione con i fatti. 
%   Ci esula da predicati non conosciuti e liste infinite da controllare.
num_colonne(4).
num_righe(4).
num_griglie(4).

valoreMaxPossibile(4).

iniziale(pos(1,1)).

% NB: i fatti commentati (mancanti nella KB) indicano le caselle vuote.
%     Li ho lasciati commentati per verificare la 
%     correttezza dell'azione assegna

% Prima riga
%cella(pos(1,1),0).
cella(pos(1,2),1).
% cella(pos(1,3),0).
cella(pos(1,4),4).

% Seconda riga
cella(pos(2,1),4).
cella(pos(2,2),2).
% cella(pos(2,3),0).
cella(pos(2,4),1).

% Terza riga
cella(pos(3,1),2).
% cella(pos(3,2),0).
% cella(pos(3,3),0).
cella(pos(3,4),3).

% Quarta riga
cella(pos(4,1),1).
% cella(pos(4,2),0).
% cella(pos(4,3),0).
% cella(pos(4,4),0).

%% Aggiunta informazione sulle griglie

% Prima griglia
griglia(pos(1,1),pos(2,2),1).

% Seconda griglia
griglia(pos(1,3),pos(2,4),2).

% Terza griglia
griglia(pos(3,1),pos(4,2),3).

% Quarta griglia
griglia(pos(3,3),pos(4,4),4).


%% PREDICATO DI USCITA: 
%    Il predicato di uscita controlla se i fatti mancanti (caselle vuote 
%    e poi riempite) sono stati definiti nella KB.
%    La definizione viene effettuata dalla strategia.
finale:-
    % Prima riga
    cella(pos(1,1),3),
    cella(pos(1,3),2),

    % Seconda riga
    cella(pos(2,3),3),

    % Terza riga
    cella(pos(3,2),4),
    cella(pos(3,3),1),

    % Quarta riga
    cella(pos(4,2),3),
    cella(pos(4,3),4),
    cella(pos(4,4),2).


