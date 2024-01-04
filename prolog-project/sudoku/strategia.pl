% Predicato Wrapper
risolviSudoku(Cammino):-
    iniziale(SudokuIniziale), % Carica lo stato iniziale
    pos(1,1),
    risolvi(SudokuIniziale,Cammino,[]),!.

risolviSudoku(Cammino):-
    iniziale(SudokuIniziale), % Carica lo stato iniziale
    retractall(pos(_,_)),
    assert(pos(1,1)),
    risolvi(SudokuIniziale,Cammino,[]),!.
    
% Check stato finale
risolvi(Sudoku,[],_):-
    finale(Sudoku).

% prova visita in profondità
% risolvi([Riga|RestoSudoku],[Az|ListaAzioni],Visitati):-
risolvi(Sudoku,[_|_],_):-
    % Prende tutte le azioni possibili sulla casella in esame
    % findall(Azione,applicabile(Azione,Sudoku),ListaAzioniApplicabili),

    applicabile(Azione,Sudoku).
    % trasforma(Azione,SudokuNuovo)
    %\+member(Snuovo,Visitati),
    %risoluzione(NuovoSudoku,ListaAzioni,[S|Visitati])
    
    % in questo modo, risolvi va in loop
    risolvi(Sudoku,[_|_],_).
    
    % else: in questo caso, esce dopo il primo scorrimento.
    % risolvi(Sudoku,[],_).


% NOTA: potrebbe essere utile, nella strategia di ricerca in ampiezza,
%   l'utilizzo di findall(X,member([1,2,3]),ListaRisultato) -> trova tutti i possibili valori di X 
%   per soddisfare il predicato centrale. Ovviamente, il risultato viene riportato nel 3o argomento.