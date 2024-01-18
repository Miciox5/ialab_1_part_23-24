% Ground
% --------------------------------------
% team(atalanta;bologna;cagliari;empoli;fiorentina;frosinone;genoa;hellas_verona;inter;juventus;lazio;lecce;milan;monza;napoli;roma;salernitana;sassuolo;torino;udinese).
team(s1;s2;s3;s4).
% citta(bergamo;bologna;cagliari;empoli;firenze;frosinone;genova;verona;milano;torino;lecce;monza;napoli;roma;salerno;reggio_emilia;udine).
citta(c1;c2;c3;c4).

in(s1,c1).
in(s2,c2).
in(s3,c3).
in(s4,c4).

giornata(1..3).



% Constraints
% --------------------------------------

% Ad ogni giornata vengono assegnate due partite per coppia di squadre
2 {partita(S1,S2,Giornata): 
    team(S1),team(S2),S1<>S2} 2 :- giornata(Giornata).

% Non si può giocare andata e ritorno nella stessa giornata
:- partita(S1,S2,G),partita(S2,S1,G).


%% Una squadra non può giocare più di una partita nella stessa giornata
% Una squadra non può giocare più di due partite in casa 
:- partita(S1,S2,G),partita(S1,S3,G),S2<>S3.
% Una squadra non può giocare una partita in casa ed una fuori casa
:- partita(S1,S2,G),partita(S3,S1,G),S2<>S3.
% Una squadra non può giocare due partite fuori casa
:- partita(S1,S2,G),partita(S3,S2,G),S1<>S3.

% Non possono esistere due partite uguali in giornate diverse
:- partita(S1,S2,G1),partita(S1,S2,G2),G1<>G2.
:- partita(S1,S2,G1),partita(S2,S1,G2),G1<>G2.


#show partita/3.

