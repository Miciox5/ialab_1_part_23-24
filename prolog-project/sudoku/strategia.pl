% Predicato Wrapper
risolviSudoku(Cammino):-
    iniziale(SudokuIniziale), % Carica lo stato iniziale
    risolvi(SudokuIniziale,Cammino,[]).

risolvi(Sudoku,[],_):-
    finale(Sudoku).

% prova visita in profondità
% risolvi([Riga|RestoSudoku],[Az|ListaAzioni],Visitati):-
risolvi(Sudoku,[_|_],_):-
    applicabile(Azione,Sudoku).
    % trasforma(Azione,SudokuNuovo)
    %\+member(Snuovo,Visitati),
    %risoluzione(NuovoSudoku,ListaAzioni,[S|Visitati])

% risolvi(Sudoku,[_|_],_):-
%     applicabile(assegna(Riga,NuovaColonna,_),Sudoku).

    % applicabile(Az,[Riga|RestoSudoku]),
    % Condizioni di start

    % trasforma(Snuovo),
    % risolvi(ListaAzioni,Visitati).

% MODIFICHE DA RIVEDERE
% % Predicato Wrapper
% prova(Cammino):-
%     iniziale(S0),
%     pos(1,1),
%     risolvi(S0,Cammino,[]),!.

% prova(Cammino):-
%     iniziale(S0),
%     retractall(pos(_,_)),
%     assert(pos(1,1)),
%     risolvi(S0,Cammino,[]),!.

% risolvi(S,[],_):-
%     finale(S),!.

% % prova visita in profondità
% % risolvi([Riga|RestoSudoku],[Az|ListaAzioni],Visitati):-
% risolvi(Sudoku,[_|_],_):-
%     findall(Azione,applicabile(Azione,Sudoku),ListaAzioniApplicabili),
%     write(ListaAzioniApplicabili),
%     % TO-DO: strategia da applicare
%     risolvi(Sudoku,[_|_],_).
%     % trasforma()



% NOTA: potrebbe essere utile, nella strategia di ricerca in ampiezza,
%   l'utilizzo di findall(X,member([1,2,3]),ListaRisultato) -> trova tutti i possibili valori di X 
%   per soddisfare il predicato centrale. Ovviamente, il risultato viene riportato nel 3o argomento.