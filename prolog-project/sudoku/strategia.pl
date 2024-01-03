% Predicato Wrapper
prova(Cammino):-
    iniziale(S0),risolvi(S0,Cammino,[]).

risolvi(S,[],_):-
    finale(S).

% prova visita in profondità
% risolvi([Riga|RestoSudoku],[Az|ListaAzioni],Visitati):-
risolvi(Sudoku,[_|_],_):-
    applicabile(Azione,Sudoku).
    % trasforma()

% risolvi(Sudoku,[_|_],_):-
%     applicabile(assegna(Riga,NuovaColonna,_),Sudoku).

    % applicabile(Az,[Riga|RestoSudoku]),
    % Condizioni di start

    % trasforma(Snuovo),
    % risolvi(ListaAzioni,Visitati).




% NOTA: potrebbe essere utile, nella strategia di ricerca in ampiezza,
%   l'utilizzo di findall(X,member([1,2,3]),ListaRisultato) -> trova tutti i possibili valori di X 
%   per soddisfare il predicato centrale. Ovviamente, il risultato viene riportato nel 3o argomento.