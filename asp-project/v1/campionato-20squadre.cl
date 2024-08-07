% Ground
% --------------------------------------

%% Dominio con 20 squadre

% team(atalanta;bologna;cagliari;empoli;fiorentina;frosinone;genoa;hellas_verona;inter;juventus;lazio;lecce;milan;monza;napoli;roma;salernitana;sassuolo;torino;udinese).
team(s1;s2;s3;s4;s5;s6;s7;s8;s9;s10;
        s11;s12;s13;s14;s15;s16;s17;s18;s19;s20).
% citta(bergamo;bologna;cagliari;empoli;firenze;frosinone;genova;verona;milano;torino;lecce;monza;napoli;roma;salerno;reggio_emilia;udine).
citta(c1;c2;c4;c5;c6;c7;c8;c9;c10;
        c11;c12;c13;c14;c15;c16;c17;c18;c19;c20;).

giocaA(s1,c1;
        s2,c2;
        s3,c2;
        s4,c4;
        s5,c5;
        s6,c6;
        s7,c7;
        s8,c8;
        s9,c9;
        s10,c10;
        s11,c11;
        s12,c12;
        s13,c13;
        s14,c14;
        s15,c15;
        s16,c16;
        s17,c17;
        s18,c18;
        s19,c19;
        s20,c20
        ).

giornataAndata(1..19).
giornataRitorno(20..38).


% % Constraints
% % --------------------------------------


% %% Dominio 20 squadre
% % -------------------
% % Ad ogni giornata di andata vengono assegnate dieci partite per coppia di squadre
10 {partitaAndata(S1,S2,GAndata,C1): 
    team(S1),
    team(S2),
    S1<>S2,
    giocaA(S1,C1)} 10 :- giornataAndata(GAndata).

% Ad ogni giornata di ritorno vengono assegnate dieci partite per coppia di squadre
10 {partitaRitorno(S1,S2,GRitorno,C1): 
    team(S1),team(S2),S1<>S2,giocaA(S1,C1)} 10 :- giornataRitorno(GRitorno).

% % -------------------

% Non si può giocare andata e ritorno nella stessa giornata di andata
:- partitaAndata(S1,S2,GAndata,C1),
    partitaAndata(S2,S1,GAndata,C2),
    giornataAndata(GAndata).

% Non si può giocare andata e ritorno nella stessa giornata di ritorno
:- partitaRitorno(S1,S2,GRitorno,C1),
    partitaRitorno(S2,S1,GRitorno,C2),
    giornataRitorno(GRitorno).


%% Una squadra non può giocare più di una partita nella stessa giornata
% Una squadra non può giocare più di due partite in casa 
:- partitaAndata(S1,S2,GAndata,C1),
    partitaAndata(S1,S3,GAndata,C1),
    S2<>S3,giornataAndata(GAndata).
% Una squadra non può giocare una partita in casa ed una fuori casa
:- partitaAndata(S1,S2,GAndata,C1),
    partitaAndata(S3,S1,GAndata,C3),
    S2<>S3,giornataAndata(GAndata).
% Una squadra non può giocare due partite fuori casa
:- partitaAndata(S1,S2,GAndata,C1),
    partitaAndata(S3,S2,GAndata,C3),
    S1<>S3,giornataAndata(GAndata).

%% Una squadra non può giocare più di una partita nella stessa giornata
% Una squadra non può giocare più di due partite in casa 
:- partitaRitorno(S1,S2,GRitorno,C1),
    partitaRitorno(S1,S3,GRitorno,C1),
    S2<>S3,giornataRitorno(GRitorno).
% Una squadra non può giocare una partita in casa ed una fuori casa
:- partitaRitorno(S1,S2,GRitorno,C1),
    partitaRitorno(S3,S1,GRitorno,C3),
    S2<>S3,giornataRitorno(GRitorno).
% Una squadra non può giocare due partite fuori casa
:- partitaRitorno(S1,S2,GRitorno,C1),
    partitaRitorno(S3,S2,GRitorno,C3),
    S1<>S3,giornataRitorno(GRitorno).


% Non possono esistere due partite uguali in giornate diverse
:- partitaAndata(S1,S2,G1Andata,C1),
    partitaAndata(S1,S2,G2Andata,C1),
    G1Andata<>G2Andata,
    giornataAndata(G1Andata),giornataAndata(G2Andata).
:- partitaAndata(S1,S2,G1Andata,C1),
    partitaAndata(S2,S1,G2Andata,C2),
    G1Andata<>G2Andata,
    giornataAndata(G1Andata),giornataAndata(G2Andata).

%Non possono esistere due partite uguali in giornate diverse
:- partitaRitorno(S1,S2,G1Ritorno,C1),
    partitaRitorno(S1,S2,G2Ritorno,C1),
    G1Ritorno<>G2Ritorno,
    giornataRitorno(G1Ritorno),giornataRitorno(G2Ritorno).
:- partitaRitorno(S1,S2,G1Ritorno,C1),
    partitaRitorno(S2,S1,G2Ritorno,C2),
    G1Ritorno<>G2Ritorno,
    giornataRitorno(G1Ritorno),giornataRitorno(G2Ritorno).
:- partitaAndata(S1,S2,GAndata,C1),
    partitaRitorno(S1,S2,GRitorno,C1),
    giornataAndata(GAndata),giornataRitorno(GRitorno).


% Una partita di andata non può essere giocata in un campo diverso da quello della squadra in casa
:- partitaAndata(S1,S2,GAndata,C1), 
    not giocaA(S1,C1).
% Una partita di ritorno non può essere giocata in un campo diverso da quello della squadra in casa
:- partitaRitorno(S1,S2,GRitorno,C1), 
    not giocaA(S1,C1).

% Due squadre, se condividono lo stesso stadio, non possono giocare una partita di andata in casa
%   nella stessa giornata
:- partitaAndata(S1,S2,GAndata,C1),
    partitaAndata(S3,S4,GAndata,C3), 
    S1<>S3, C1==C3.

% Due squadre, se condividono lo stesso stadio, non possono giocare una partita di ritorno in casa
%   nella stessa giornata
:- partitaRitorno(S1,S2,GRitorno,C1),
    partitaRitorno(S3,S4,GRitorno,C3), 
    S1<>S3, C1==C3.

%---- Vincoli facoltativi ----

% Ciascuna squadra non deve giocare mai più di due partite consecutive in casa

% :-partitaAndata(S1,_,G,_),
%     partitaAndata(S1,_,G+1,_),
%     partitaAndata(S1,_,G+2,_).

% :-partitaAndata(_,S1,G,_),
%     partitaAndata(_,S1,G+1,_),
%     partitaAndata(_,S1,G+2,_).

% :-partitaRitorno(S1,_,G,_),
%     partitaRitorno(S1,_,G+1,_),
%     partitaRitorno(S1,_,G+2,_).

% :-partitaRitorno(_,S1,G,_),
%     partitaRitorno(_,S1,G+1,_),
%     partitaRitorno(_,S1,G+2,_).

% :-partitaAndata(S1,_,G,_),
%     partitaAndata(S1,_,G+1,_),
%     partitaRitorno(S1,_,G+2,_).

% :-partitaAndata(_,S1,G,_),
%     partitaAndata(_,S1,G+1,_),
%     partitaRitorno(_,S1,G+2,_).

% :-partitaAndata(S1,_,G,_),
%     partitaRitorno(S1,_,G+1,_),
%     partitaRitorno(S1,_,G+2,_).

% :-partitaAndata(_,S1,G,_),
%     partitaRitorno(_,S1,G+1,_),
%     partitaRitorno(_,S1,G+2,_).
    
% La distanza tra una coppia di gare di andata e ritorno è di almeno 10 giornate

:- partitaAndata(S1, S2, G1, _),partitaRitorno(S2, S1, G2, _), G2<G1+10.

% #show partitaRitorno/4.
% #show partitaAndata/4.