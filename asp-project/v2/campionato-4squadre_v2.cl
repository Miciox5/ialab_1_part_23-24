% Ground
% --------------------------------------

%% Dominio con 4 squadre
% -------------------
squadra(juventus;
    milan;
    inter;
    roma).

citta(c_torino;
        c_milano;
        c_roma).

% Ogni squadra fa riferimento ad una città, che offre la struttura in cui la squadra gioca gli incontri in casa
gioca_a(juventus,c_torino;
        milan,c_milano;
        inter,c_milano;
        roma,c_roma).

giornata(andata,1..3).
giornata(ritorno,4..6).

partita(andata,S1,S2,G,C1):-
    squadra(S1),
    squadra(S2),
    S1<>S2,
    giornata(andata,G),
    % ogni squadra fa riferimento ad una città, che offre la struttura in cui la squadra gioca gli incontri in casa;
    gioca_a(S1,C1).

partita(ritorno,S1,S2,G,C1):-
    squadra(S1),
    squadra(S2),
    S1<>S2,
    giornata(ritorno,G),
    % ogni squadra fa riferimento ad una città, che offre la struttura in cui la squadra gioca gli incontri in casa;
    gioca_a(S1,C1).

4 {partita(AR,S1,S2,G,C1):squadra} 4:-giornata(AR,G).

% Ad ogni squadra può giocare una partita in una giornata
 {partita(andata,S1,S2,G,C1): 
    giornata(andata,G)} :-squadra(S1),squadra(S2),gioca_a(S1,C1).


% il campionato prevede 38 giornate, 19 di andata e 19 
%   di ritorno NON simmetriche, ossia la giornata 1 di ritorno 
%   non coincide necessariamente con 
%   la giornata 1 di andata a campi invertiti;
% 2  {partita(andata,S1,S2,G,C1):
%     squadra(S1),    
%     squadra(S2),
%     S1!=S2,
%     S1<S2,
%     gioca_a(S1,C1)} 2 :- giornata(andata,G).

% 2  {partita(ritorno,S1,S2,G,C1):
%     squadra(S1),    
%     squadra(S2),
%     S1!=S2,
%     S1<S2,
%     gioca_a(S1,C1)} 2 :- giornata(ritorno,G).

% npg(S,G,N) :-
%     N = #count { 1 : partita(_, S, _, G, _) ; 1 : partita(_, _, S, G, _) }, 
%     squadra(S),
%     giornata(_, G),
%     N <> 1.

% :- npg(S,G,N), N!=1.

% :- partita(andata,S1,S2,G,_), 
%     partita(ritorno,S1,S2,G+2,_).

% :- partita(andata,S1,S2,G1,_), 
%     partita(andata,S1,S2,G2,_), 
%     G1!=G2,
%     G1<G2. 

% :- partita(ritorno,S1,S2,G3,_), 
%     partita(ritorno,S1,S2,G4,_), 
%     G3!=G4,
%     G3<G4.

#show partita/5.