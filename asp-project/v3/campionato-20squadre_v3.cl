% CAMPIONATO A 20 SQUADRE

% Vincoli obbligatori
% --------------------------------------

% --- Ground ----
team(1; % atalanta
     2; % bologna
     3; % cagliari
     4; % empoli
     5; % fiorentina
     6; % frosinone
     7; % genoa
     8; % hellas_verona
     9; % inter
     10; % juventus
     11; % lazio
     12; % lecce
     13; % milan
     14; % monza
     15; % napoli
     16; % roma
     17; % salernitana
     18; % sassuolo
     19; % torino
     20). % udinese

% Ogni squadra fa riferimento ad una città, che offre la struttura in cui la squadra gioca gli incontri in casa;
gioca_a(1,1; % atalanta, citta_bergamo
        2,2; % bologna, citta_bologna
        3,3; % cagliari, citta_cagliari
        4,4; % empoli, citta_empoli
        5,5; % fiorentina, citta_firenze
        6,6; % frosinone, citta_frosinone
        7,7; % genoa, citta_genova
        8,8; % hellas_verona, citta_verona
        9,9; % inter, citta_milano
        10,10; % juventus, citta_torino_stadium
        11,11; % lazio, citta_lazio_roma
        12,12; % lecce, citta_lecce
        13,9; % milan, citta_milano
        14,14; % monza, citta_monza
        15,15; % napoli, citta_napoli
        16,16; % roma, citta_roma
        17,17; % salernitana, citta_salerno
        18,18; % sassuolo, citta_reggio_emilia
        19,10; % torino, citta_torino_olimpico
        20,20). % udinese, citta_udine

% Giornate: andata, ritorno
giornata(1..38).
giornata_andata(1..19).
giornata_ritorno(20..38).

% --- End ground ----

% Ogni squadra si sfida all'andata e al ritorno un numero di volte pari al numero di squadre totali / 2 
10 {partita(andata, SquadraA, SquadraB, Citta, N):
    team(SquadraA), 
    team(SquadraB), 
    gioca_a(SquadraA,Citta),
    SquadraA <> SquadraB} 10 :- giornata_andata(N).

% le partite di ritorno sono speculari alle partite di andata ma in altre giornate
10 {partita(ritorno, SquadraA, SquadraB, Citta, N): 
    team(SquadraA), 
    team(SquadraB), 
    gioca_a(SquadraA, Citta),
    partita(andata, SquadraB, SquadraA, Citta2, _),
    gioca_a(SquadraB,Citta2)} 10:- giornata_ritorno(N).

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
    G2 - G1 < 10.

#show partita/5.