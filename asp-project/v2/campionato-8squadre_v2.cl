% Ground
% --------------------------------------

#const num_squadre = 8.
#const num_partite = (num_squadre-1)*2.

%% Dominio con 8 squadre
% -------------------
squadra(juventus;
    milan;
    inter;
    roma;
    atalanta;
    bologna;
    fiorentina;
    napoli).
    
citta(c_torino;
        c_milano;
        c_roma;
        c_bergamo;
        c_bologna;
        c_firenze;
        c_napoli).

giocaA(juventus,c_torino;
        milan,c_milano;
        inter,c_milano;
        roma,c_roma;
        atalanta,c_bergamo;
        bologna,c_bologna;
        fiorentina,c_firenze;
        napoli,c_napoli).

giornata(andata,1..(num_partite/2)).
giornata(ritorno,(num_partite/2)+1..(num_partite)).

% Constraints
% --------------------------------------

%---- Vincoli obblifatori ----

%% Dominio 8 squadre
% -------------------
% Ad ogni giornata di andata/ritorno vengono assegnate quattro partite per coppia di squadre
num_partite {partita(AR,S1,S2,GAndata,C1): 
    squadra(S1),
    squadra(S2),
    S1<>S2,
    giocaA(S1,C1)} num_partite :- giornata(AR,GAndata).

% -------------------

:-  squadra(Squadra), 
    giornata(G),
    NP_A = #count{SquadraA: partita(_,Squadra,SquadraA,G,_)}, 
    NP_B = #count{SquadraB: partita(_,SquadraB,Squadra,G,_)}, 
    NP_A + NP_B <> 1.


#show partita/5.
% #show np/2.
