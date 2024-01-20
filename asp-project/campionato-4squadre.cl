% Ground
% --------------------------------------

%% Dominio con 4 squadre
% -------------------
team(s1;s2;s3;s4).
citta(c1;c2;c4).

giocaA(s1,c1;
        s2,c2;
        s3,c2;
        s4,c4).

giornataAndata(1..3).
giornataRitorno(4..6).

% Constraints
% --------------------------------------

%% Dominio 4 squadre
% -------------------
% Ad ogni giornata di andata vengono assegnate due partite per coppia di squadre
2 {partitaAndata(S1,S2,GAndata,giocaA(S1,C1)): 
    team(S1),team(S2),S1<>S2,citta(C1)} 2 :- giornataAndata(GAndata).

% Ad ogni giornata di ritorno vengono assegnate due partite per coppia di squadre
2 {partitaRitorno(S1,S2,GRitorno,giocaA(S1,C1)): 
    team(S1),team(S2),S1<>S2,citta(C1)} 2 :- giornataRitorno(GRitorno).
% -------------------

% Non si può giocare andata e ritorno nella stessa giornata di andata
:- partitaAndata(S1,S2,GAndata,giocaA(S1,C1)),partitaAndata(S2,S1,GAndata,giocaA(S2,C2)),giornataAndata(GAndata).

% Non si può giocare andata e ritorno nella stessa giornata di ritorno
:- partitaRitorno(S1,S2,GRitorno,giocaA(S1,C1)),partitaRitorno(S2,S1,GRitorno,giocaA(S2,C2)),giornataRitorno(GRitorno).


%% Una squadra non può giocare più di una partita nella stessa giornata
% Una squadra non può giocare più di due partite in casa 
:- partitaAndata(S1,S2,GAndata,giocaA(S1,C1)),partitaAndata(S1,S3,GAndata,giocaA(S1,C1)),S2<>S3,giornataAndata(GAndata).
% Una squadra non può giocare una partita in casa ed una fuori casa
:- partitaAndata(S1,S2,GAndata,giocaA(S1,C1)),partitaAndata(S3,S1,GAndata,giocaA(S3,C3)),S2<>S3,giornataAndata(GAndata).
% Una squadra non può giocare due partite fuori casa
:- partitaAndata(S1,S2,GAndata,giocaA(S1,C1)),partitaAndata(S3,S2,GAndata,giocaA(S3,C3)),S1<>S3,giornataAndata(GAndata).

%% Una squadra non può giocare più di una partita nella stessa giornata
% Una squadra non può giocare più di due partite in casa 
:- partitaRitorno(S1,S2,GRitorno,giocaA(S1,C1)),partitaRitorno(S1,S3,GRitorno,giocaA(S1,C1)),S2<>S3,giornataRitorno(GRitorno).
% Una squadra non può giocare una partita in casa ed una fuori casa
:- partitaRitorno(S1,S2,GRitorno,giocaA(S1,C1)),partitaRitorno(S3,S1,GRitorno,giocaA(S3,C3)),S2<>S3,giornataRitorno(GRitorno).
% Una squadra non può giocare due partite fuori casa
:- partitaRitorno(S1,S2,GRitorno,giocaA(S1,C1)),partitaRitorno(S3,S2,GRitorno,giocaA(S3,C3)),S1<>S3,giornataRitorno(GRitorno).


% Non possono esistere due partite uguali in giornate diverse
:- partitaAndata(S1,S2,G1Andata,giocaA(S1,C1)),partitaAndata(S1,S2,G2Andata,giocaA(S1,C1)),G1Andata<>G2Andata,
    giornataAndata(G1Andata),giornataAndata(G2Andata).
:- partitaAndata(S1,S2,G1Andata,giocaA(S1,C1)),partitaAndata(S2,S1,G2Andata,giocaA(S2,C2)),G1Andata<>G2Andata,
    giornataAndata(G1Andata),giornataAndata(G2Andata).

%Non possono esistere due partite uguali in giornate diverse
:- partitaRitorno(S1,S2,G1Ritorno,giocaA(S1,C1)),partitaRitorno(S1,S2,G2Ritorno,giocaA(S1,C1)),G1Ritorno<>G2Ritorno,
    giornataRitorno(G1Ritorno),giornataRitorno(G2Ritorno).
:- partitaRitorno(S1,S2,G1Ritorno,giocaA(S1,C1)),partitaRitorno(S2,S1,G2Ritorno,giocaA(S2,C2)),G1Ritorno<>G2Ritorno,
    giornataRitorno(G1Ritorno),giornataRitorno(G2Ritorno).
:- partitaAndata(S1,S2,GAndata,giocaA(S1,C1)),partitaRitorno(S1,S2,GRitorno,giocaA(S1,C1)),
    giornataAndata(GAndata),giornataRitorno(GRitorno).


% Una partita di andata non può essere giocata in un campo diverso da quello della squadra in casa
:- partitaAndata(S1,S2,GAndata,giocaA(S1,C1)), 
    not giocaA(S1,C1).
% Una partita di ritorno non può essere giocata in un campo diverso da quello della squadra in casa
:- partitaRitorno(S1,S2,GRitorno,giocaA(S1,C1)), 
    not giocaA(S1,C1).

% Due squadre, se condividono lo stesso stadio, non possono giocare una partita di andata in casa
%   nella stessa giornata
:- partitaAndata(S1,S2,GAndata,giocaA(S1,C1)),
    partitaAndata(S3,S4,GAndata,giocaA(S3,C3)), 
    S1<>S3, C1==C3.

% Due squadre, se condividono lo stesso stadio, non possono giocare una partita di ritorno in casa
%   nella stessa giornata
:- partitaRitorno(S1,S2,GRitorno,giocaA(S1,C1)),
    partitaRitorno(S3,S4,GRitorno,giocaA(S3,C3)), 
    S1<>S3, C1==C3.

%---- Vincoli facoltativi ----

% Ciascuna squadra non deve giocare ma più di due partite consecutive in casa

:-partitaAndata(S1,_,G,_),
    partitaAndata(S1,_,G+1,_),
    partitaAndata(S1,_,G+2,_).

:-partitaAndata(_,S1,G,_),
    partitaAndata(_,S1,G+1,_),
    partitaAndata(_,S1,G+2,_).

:-partitaRitorno(S1,_,G,_),
    partitaRitorno(S1,_,G+1,_),
    partitaRitorno(S1,_,G+2,_).

:-partitaRitorno(_,S1,G,_),
    partitaRitorno(_,S1,G+1,_),
    partitaRitorno(_,S1,G+2,_).

% La distanza tra una coppia di gare di andata e ritorno è di almeno 3 giornate

:- partitaAndata(S1, S2, G1, _),partitaRitorno(S2, S1, G2, _), G2<G1+2.

#show partitaAndata/4.
#show partitaRitorno/4.

