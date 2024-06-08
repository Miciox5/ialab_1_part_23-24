% CAMPIONATO A 4 SQUADRE

% Vincoli obbligatori
% --------------------------------------

% --- Ground ----
team(inter;
     juventus;
     milan;
     roma).

% Ogni squadra fa riferimento ad una città, che offre la struttura in cui la squadra gioca gli incontri in casa;
gioca_a(inter,citta_milano;
        juventus,citta_torino_stadium;
        milan,citta_milano;
        roma,citta_roma).

% Giornate: andata, ritorno
giornata(1..6).
giornata_andata(1..3).
giornata_ritorno(4..6).

% --- End ground ----

% Ogni squadra si sfida all'andata e al ritorno un numero di volte pari al numero di squadre totali / 2 
2 {partita(andata, SquadraA, SquadraB, Citta, N):
    team(SquadraA), 
    team(SquadraB), 
    gioca_a(SquadraA,Citta),
    SquadraA <> SquadraB} 2 :- giornata_andata(N).

% le partite di ritorno sono speculari alle partite di andata ma in altre giornate
2 {partita(ritorno, SquadraA, SquadraB, Citta, N): 
    team(SquadraA), 
    team(SquadraB), 
    gioca_a(SquadraA, Citta),
    partita(andata, SquadraB, SquadraA, Citta2, _),
    gioca_a(SquadraB,Citta2)} 2:- giornata_ritorno(N).

% Nella stessa giornata, una squadra non può giocare 2 volte
:-  team(Squadra), 
    giornata(Giornata),
    Numero_Partite_A = #count{SquadraA: partita(_,Squadra,SquadraA,_, Giornata)}, 
    Numero_Partite_B = #count{SquadraB: partita(_,SquadraB,Squadra,_, Giornata)}, 
    Numero_Partite_A + Numero_Partite_B <> 1.

% Non può capitare che due squadre giocano 2 partite all'andata o al ritorno
:-  partita(_, SquadraA, SquadraB, _, N1), 
    partita(_, SquadraA, SquadraB, _, N2),
    N1 <> N2.

% Non può capitare che due squadre giocano andata e ritorno solo all'andata o solo al ritorno
:-  partita(Tipo, SquadraA, SquadraB, _, _), 
    partita(Tipo, SquadraB, SquadraA, _, _).

% Le giornate di andata e ritorno NON sono simmetriche
:-  partita(andata,SquadraA,SquadraB, _, G1), 
    partita(ritorno,SquadraB,SquadraA, _, G2), 
    G2 == G1 + 19.

% Non può capitare che 2 squadre diverse giocano partite differenti nello stesso stadio nella stessa giornata
:-  partita(Tipo, Squadra1, _, C1, N), 
    partita(Tipo, Squadra2, _, C2, N),
    Squadra1 <> Squadra2,
    C1 == C2.

% Vincoli facoltativi
% --------------------------------------
% Ciascuna squadra non deve giocare mai più di due partite consecutive in casa o fuori casa;
:-  partita(_, Squadra, _, _, G1),
    partita(_, Squadra, _, _, G1+1),
    partita(_, Squadra, _, _, G1+2).

:-  partita(_, _, Squadra, _, G1),
    partita(_, _, Squadra, _, G1+1),
    partita(_, _, Squadra, _, G1+2).

% La distanza tra una coppia di gare di andata e ritorno è di almeno 10 giornate, (N squadre / 2)
%  ossia se SquadraA vs SquadraB è programmata per la giornata 12, il ritorno
%  SquadraB vs SquadraA verrà schedulato non prima dalla giornata 22.

:-  partita(andata, SquadraA, SquadraB, _, G1),
    partita(ritorno, SquadraB, SquadraA, _, G2),
    G2 - G1 < 2.

#show partita/5.