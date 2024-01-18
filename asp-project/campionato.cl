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

giornataAndata(1..3).
giornataRitorno(4..6).



% Constraints
% --------------------------------------

% Ad ogni giornata di andata vengono assegnate due partite per coppia di squadre
2 {partita(S1,S2,GAndata): 
    team(S1),team(S2),S1<>S2} 2 :- giornataAndata(GAndata).

% Ad ogni giornata di ritorno vengono assegnate due partite per coppia di squadre
2 {partita(S1,S2,GRitorno): 
    team(S1),team(S2),S1<>S2} 2 :- giornataRitorno(GRitorno).


% Non si può giocare andata e ritorno nella stessa giornata di andata
:- partita(S1,S2,GAndata),partita(S2,S1,GAndata),giornataAndata(GAndata).

% Non si può giocare andata e ritorno nella stessa giornata di ritorno
:- partita(S1,S2,GRitorno),partita(S2,S1,GRitorno),giornataRitorno(GRitorno).


%% Una squadra non può giocare più di una partita nella stessa giornata
% Una squadra non può giocare più di due partite in casa 
:- partita(S1,S2,GAndata),partita(S1,S3,GAndata),S2<>S3,giornataAndata(GAndata).
% Una squadra non può giocare una partita in casa ed una fuori casa
:- partita(S1,S2,GAndata),partita(S3,S1,GAndata),S2<>S3,giornataAndata(GAndata).
% Una squadra non può giocare due partite fuori casa
:- partita(S1,S2,GAndata),partita(S3,S2,GAndata),S1<>S3,giornataAndata(GAndata).

%% Una squadra non può giocare più di una partita nella stessa giornata
% Una squadra non può giocare più di due partite in casa 
:- partita(S1,S2,GRitorno),partita(S1,S3,GRitorno),S2<>S3,giornataRitorno(GRitorno).
% Una squadra non può giocare una partita in casa ed una fuori casa
:- partita(S1,S2,GRitorno),partita(S3,S1,GRitorno),S2<>S3,giornataRitorno(GRitorno).
% Una squadra non può giocare due partite fuori casa
:- partita(S1,S2,GRitorno),partita(S3,S2,GRitorno),S1<>S3,giornataRitorno(GRitorno).


% Non possono esistere due partite uguali in giornate diverse
:- partita(S1,S2,G1Andata),partita(S1,S2,G2Andata),G1Andata<>G2Andata,
    giornataAndata(G1Andata),giornataAndata(G2Andata).
:- partita(S1,S2,G1Andata),partita(S2,S1,G2Andata),G1Andata<>G2Andata,
    giornataAndata(G1Andata),giornataAndata(G2Andata).

% Non possono esistere due partite uguali in giornate diverse
:- partita(S1,S2,G1Ritorno),partita(S1,S2,G2Ritorno),G1Ritorno<>G2Ritorno,
    giornataRitorno(G1Ritorno),giornataRitorno(G2Ritorno).
:- partita(S1,S2,G1Ritorno),partita(S2,S1,G2Ritorno),G1Ritorno<>G2Ritorno,
    giornataRitorno(G1Ritorno),giornataRitorno(G2Ritorno).


#show partita/3.

