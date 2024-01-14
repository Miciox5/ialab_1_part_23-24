:- dynamic cella/2.  %per modificare dinamicamente la base di conoscenza durante l'esecuzione
:- dynamic note/2.
%% FUNZIONI applicabile()

applicabile(ricomincia,pos(Riga,Colonna)):-
    num_righe(MaxRighe),
    Riga==MaxRighe,
    num_colonne(MaxColonne),
    Colonna > MaxColonne,
    numeroCelle(NC),
    write(NC),
    nl,write('---Entra in ricomincia---'),nl,nl.

applicabile(assegna,pos(Riga,Colonna)):-
    num_righe(MaxRighe),
    Riga =< MaxRighe,
    num_colonne(MaxColonne),
    Colonna =< MaxColonne,
    \+cella(pos(Riga,Colonna),_),
    write('Casella vuota in posizione -> ('),write(Riga),write(':'),write(Colonna),write(')'),nl.

applicabile(scorriRiga,pos(_,Colonna)):-
    num_colonne(MaxColonne),
    NuovaColonna is Colonna+1,
    MaxRange is MaxColonne+1,
    NuovaColonna =< MaxRange.
 
applicabile(cambiaRiga,pos(Riga,_)):-
    num_righe(MaxRighe),
    NuovaRiga is Riga+1,
    NuovaRiga =< MaxRighe.


%% FUNZIONI trasforma()

% parameter: ricomincia
%   La funzione ha il compito di riposizionare il solver sullo stato 
%   iniziale se non si è ancora trovata una soluzione
trasforma(ricomincia,pos(_,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is 1,
    NuovaColonna is 1.

% parameter: assegna
%   La funzione ha il compito di assegnare ad una casella vuota un valore
%   secondo la strategia di ricerca.

trasforma(assegna,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    ricercaValoriPossibili(pos(Riga,Colonna),NewListaPossibili),
    % write('NewListaPossibili: '),
    % write(NewListaPossibili),nl,
    % Assegnamento one shot
    % --------
    length(NewListaPossibili, NPossibili),
    NPossibili >0,
    NPossibili ==1,
    nth1(1,NewListaPossibili,ValoreDaAssegnare),
    write('Assegnamento One Shot: '),write(ValoreDaAssegnare),nl,
    assert(cella(pos(Riga,Colonna),ValoreDaAssegnare)),
    % --------
    numeroCelle(NC),
    UpdateNC is NC+1,
    retract(numeroCelle(_)),
    assert(numeroCelle(UpdateNC)),
    NuovaColonna is Colonna+1.

% parameter: scorri
%   La funzione ha il compito di scorrere la posizione della colonna, 
%   aggiornato lo stato attuale.
trasforma(scorriRiga,pos(Riga,Colonna),pos(Riga,NuovaColonna)):-
    NuovaColonna is Colonna+1.


% parameter: scorriRiga
%   La funzione ha il compito di scorrere la posizione della riga dopo
%   averla esaminata, aggiornando lo stato.
trasforma(cambiaRiga,pos(Riga,_),pos(NuovaRiga,NuovaColonna)):-
    NuovaRiga is Riga+1,
    NuovaColonna is 1.

%% PREDICATI AUSILIARI

% Applicazione tecniche di ricerca di valori ovvi

ricercaValoriPossibili(pos(Riga,Colonna),Risultato):-
    singoliOvvi(Riga,Colonna,Risultato).
    
% ricercaValoriPossibili(pos(Riga,Colonna),Risultato):-
%     coppieOvvie(Riga,Colonna,Risultato),
%     write('Risultato Singoli Nascosti'),
%     write(Risultato),nl.

ricercaValoriPossibili(pos(Riga,Colonna),Risultato):-
    singoliNascosti(Riga,Colonna,Risultato).
    % write('Risultato Singoli Nascosti'),
    % write(Risultato),nl.

%% TECNICHE

%% Tecnica: Singoli Ovvi
singoliOvvi(Riga,Colonna,LPGriglie):-
    listaPossibili(ListaPossibili),
    controlloRiga(Riga,ListaPossibili,LPRighe),
    controlloColonna(Colonna,LPRighe,LPColonne),
    controlloGriglia(Riga,Colonna,LPColonne,LPGriglie).

%% Tecnica: Coppie Ovvie
% coppieOvvie(Riga,Colonna,LPGriglie):-
%     listaPossibili(ListaPossibili),
%     controlloRiga(Riga,ListaPossibili,LPRighe),
%     controlloColonna(Colonna,LPRighe,LPColonne),
%     controlloGriglia(Riga,Colonna,LPColonne,LPGriglie),
    % da continuare.

%% Tecnica: Singoli Nascosti
singoliNascosti(Riga,Colonna,SingoloNascosto):-
    write('--In singoli nascosti--'),nl,
    listaPossibili(ListaPossibili),
    controlloRiga(Riga,ListaPossibili,LPRighe),
    controlloColonna(Colonna,LPRighe,LPColonne),
    controlloGriglia(Riga,Colonna,LPColonne,LPGriglie),!,

    % Cerca la griglia e crea le note dei possibili valori per ogni casella vuota
    griglia(NumeroGriglia, ListaElemInGriglia),
    member(pos(Riga,Colonna), ListaElemInGriglia),!,
    select(pos(Riga,Colonna), ListaElemInGriglia, LEInGriglia),
    LPVuote = [],
    trovaPosizioniVuote(LEInGriglia,LPVuote,Result),!,
    Inizio=[],
    noteCella(Result,Inizio,Note),
    % 

    ricercaSingoloNascosto(LPGriglie,Note,SingoloNascosto),!,
    write('Singolo Nascosto: '),
    writeln(SingoloNascosto),
    retractall(note(P,V)),!.

trovaPosizioniVuote([],Result, Result).
trovaPosizioniVuote([pos(R,C)|RestoPosizioni],LPVuote,Result):-
    \+cella(pos(R,C),Valore),
    trovaPosizioniVuote(RestoPosizioni,[pos(R,C)|LPVuote],Result).
trovaPosizioniVuote([pos(R,C)|RestoPosizioni],LPVuote,Result):-
    trovaPosizioniVuote(RestoPosizioni,LPVuote,Result).

noteCella([],Ris,Ris).
noteCella([pos(R,C)|AltrePosizioni], Celle, Ris):-
    listaPossibili(ListaPossibili),
    controlloRiga(R,ListaPossibili,LPRighe),
    controlloColonna(C,LPRighe,LPColonne),
    controlloGriglia(R,C,LPColonne,Possibili),
    % assert(note(pos(R,C),Possibili)),
    noteCella(AltrePosizioni,[note(pos(R,C),Possibili)|Celle],Ris).

ricercaSingoloNascosto(Risultato , [], Risultato).
ricercaSingoloNascosto(Possibili , [note(Posizione,VNota)|RestoVNota], Risultato):-
    subtract(Possibili,VNota,NuoviPossibili),
    ricercaSingoloNascosto(NuoviPossibili, RestoVNota, Risultato).

% Ricerca nella RIGA

controlloRiga(Riga,Iniziale,Finale):-
    findall(Valore, cella(pos(Riga, _), Valore), Valori),
    subtract(Iniziale, Valori, Finale).

% Ricerca nella COLONNA

controlloColonna(Colonna,Iniziale, Finale):-
    findall(Valore, cella(pos(_, Colonna), Valore), Valori),
    subtract(Iniziale, Valori, Finale).

% Ricerca nella GRIGLIA

controlloGriglia(Riga, Colonna,Iniziale, Finale):-
    trovaValoriInGriglia(pos(Riga,Colonna),NumeroGriglia, ValoriInGriglia),
    subtract(Iniziale, ValoriInGriglia,Finale).

trovaValoriInGriglia(Posizione, NumeroGriglia, ValoriInGriglia):-
    griglia(NumeroGriglia, ListaPosizioni),
    member(Posizione, ListaPosizioni),!,
    prendiValoriInGriglia(ListaPosizioni, ValoriInGriglia),!.

prendiValoriInGriglia([], []).
prendiValoriInGriglia([Posizione|RestoPosizioni], ValoriInGriglia):-
    findall(Valore, cella(Posizione, Valore), Valori),
    append(Valori, RestoValoriInGriglia, ValoriInGriglia),
    prendiValoriInGriglia(RestoPosizioni, RestoValoriInGriglia).


% Ricerca nelle righe vicine

% controlloRigheVicine(Riga, Colonna, ListaP, IntersezioneColonne) :-
%     griglia(NumeroGriglia, ListaPosizioni),
%     member(pos(Riga, Colonna), ListaPosizioni), !,
%     findall(pos(RigaQ, Colonna), member(pos(RigaQ, Colonna), ListaPosizioni), TestColonna),
%     select(pos(Riga, Colonna), TestColonna, TestColonnaRes),
%     ListaValoriDaCercare = [],
%     ricercaValoreInRigheVicine(TestColonnaRes, ListaValoriDaCercare, ListaDiListeRighe),
%     % Intersezione tra tutti i valori contenuti nelle altre due righe
%     intersezioneDiListe(ListaDiListeRighe,RisultatoRighe),
%     % Intersezione tra i valori possibili ed il risultato della funzione precedente
%     intersection(ListaP,RisultatoRighe,IntersezioneRighe),
%     findall(pos(Riga, ColonnaQ), member(pos(Riga, ColonnaQ), ListaPosizioni), TestRiga),
%     select(pos(Riga, Colonna), TestRiga, TestRigaRes),
%     ListaValoriDaCercare1 = [],
%     ricercaValoreInColonneVicine(TestRigaRes, ListaValoriDaCercare1, ListaDiListeColonne),
%     intersezioneDiListe(ListaDiListeColonne,RisultatoColonne),
%     intersection(IntersezioneRighe,RisultatoColonne,IntersezioneColonne),
%     write('Intersezione colonne: '),
%     write(IntersezioneColonne),nl.
    % length(Risultato,NRisultato),
    % NRisultato == 1.
    % controlloRiga()

%% Ricerca Valori in righe vicine

% ricercaValoreInRigheVicine([], Risultato, Risultato).

% ricercaValoreInRigheVicine([pos(Riga, _)|AltrePRigheVicine], ListaValoriDaCercare, RisultatoFinale) :-
%     findall(Valore, cella(pos(Riga, _), Valore), ValoriInRiga),
%     ricercaValoreInRigheVicine(AltrePRigheVicine, [ValoriInRiga|ListaValoriDaCercare], RisultatoFinale).

%% Ricerca valori in colonne vicine

% ricercaValoreInColonneVicine([], Risultato, Risultato).

% ricercaValoreInColonneVicine([pos(_, Colonna)|AltrePColonneVicine], ListaValoriDaCercare1, RisultatoFinale) :-
%     findall(Valore, cella(pos(_, Colonna), Valore), ValoriInColonna),
%     ricercaValoreInColonneVicine(AltrePColonneVicine, [ValoriInColonna|ListaValoriDaCercare1], RisultatoFinale).

%% Ricerca nelle colonne vicine

%% Intersezione Lista di Liste

intersezioneDiListe(ListaDiListe, Intersezione):-
    length(ListaDiListe,NListaDiListe),
    NListaDiListe >=2,!,
    foldl(intersection, ListaDiListe, Infinito, Intersezione),
    Intersezione \= Infinito.  % Rimuovi l'elemento "infinito" che foldl usa come elemento iniziale.
    
intersezioneDiListe(ListaDiListe, Intersezione) :-
    nth1(1,ListaDiListe,Intersezione).

%% Sottrazione Lista di Liste
sottrazioneListaDiListe(ListeDiListe, Risultato) :-
    length(ListeDiListe, NListaDiListe),
    NListaDiListe >= 2, !,
    foldl(sottrazioneDiListe, ListeDiListe, [], Risultato).

% Predicato ausiliario per sottrarre una lista da un insieme
sottrazioneDiListe(Lista, RisultatoParziale, RisultatoFinale) :-
    subtract(RisultatoParziale, Lista, RisultatoFinale).


% Unione di Liste di Liste
unioneListaDiListe(ListeDiListe, Unione) :-
    foldl(union, ListeDiListe, [], Unione).
