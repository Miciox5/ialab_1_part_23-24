% CONSIDERAZIONI:
%Time: 10.373s     vs      Time: 50.291s(campionato-12squadre)

% 1. Sostituzione di partitaAndata e partitaRitorno con partita(tipo,....)
% permette di non raddoppiare i vincoli sulle partite di andata e ritorno
% 2. Sostituzione di giocaA in partita direttamente con la città
% così si eliminano i vincoli col not e sembra essere più veloce.

% SE NON FUNZIONA CON 16 SQUADRE TOGLIERE I VINCOLI FACOLTATIVI E PORTARE 
% COMUNQUE QUESTE CONSIDERAZIONI ALL'ESAME.  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% Dominio con 12 squadre
% -------------------
team(s1;s2;s3;s4;s5;s6;
    s7;s8;s9;s10;s11;s12).
citta(c1;c2;c4;c5;c6;
    c7;c8;c9;c10;c11;c12).

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
        s12,c12
        ).

giornataAndata(1..11).
giornataRitorno(12..22).


% -------------------
% Ad ogni giornata di andata vengono assegnate quattro partite per coppia di squadre
6 {partita(andata,S1,S2,GAndata,C1): 
    team(S1),team(S2),S1<>S2,giocaA(S1,C1)} 6 :- giornataAndata(GAndata).

% Ad ogni giornata di ritorno vengono assegnate quattro partite per coppia di squadre
6 {partita(ritorno,S1,S2,GRitorno,C1): 
    team(S1),team(S2),S1<>S2,giocaA(S1,C1),
    partita(andata,S2,S1,_,C2),giocaA(S2,C2)} 6 :- giornataRitorno(GRitorno).

% -------------------


% Non possono esistere due partite uguali in giornate diverse
:- partita(_,S1,S2,G1,_),partita(_,S1,S2,G2,_),G1<>G2.
% una squadra non può affrontare un ritorno nell'andata
:- partita(Tipo1,S1,S2,_,_),partita(Tipo2,S2,S1,_,_),Tipo1==Tipo2.


%una squadra può giocare solo una volta in una giornata 
% in casa
:- partita(_,S1,S2,G1,_),partita(_,S1,S3,G1,_),S2<>S3.
% fuori casa
:- partita(_,S2,S1,G1,_),partita(_,S3,S1,G1,_),S2<>S3.
% una in casa e una fuori casa 
:- partita(_,S1,S2,G1,_),partita(_,S3,S1,G1,_),S2<>S3.

% Due squadre, se condividono lo stesso stadio, non possono giocare una partita
%   nella stessa giornata
:- partita(T,S1,S2,GAndata,C1),partita(T,S3,S4,GAndata,C3), S1<>S3, C1==C3.

%---- Vincoli facoltativi ----

% Ciascuna squadra non deve giocare ma più di due partite consecutive in casa
:-partita(_,S1,_,G,_),partita(_,S1,_,G+1,_),partita(_,S1,_,G+2,_).

% La distanza tra una coppia di gare di andata e ritorno è di almeno 4 giornate
:- partita(andata,S1, S2, G1, _),partita(ritorno,S2, S1, G2, _), G2<G1+5.

#show partita/5.