
:- initialization(main, main).

main :-
    % Caricamento dei file necessari
    consult("sudoku/dominio4x4facile.pl"),
    consult("sudoku/azioni-euristiche.pl"),
    consult("sudoku/strategia.pl"),
    write('File loaded. Ready to go!\n'),
    main_program.

% Ritornato sia il Cammino, sia il tempo di esecuzione 
main_program :-
    writeln('This is your main program.\n'),
    statistics(runtime, [Start|_]),
    strategiaDiRicerca(Cammino),!,
    writeln(Cammino),
    statistics(runtime, [End|_]),
    format('Start time: ~w ms~n', [Start]),
    format('End time: ~w ms~n', [End]),
    Time is (End - Start) / 1000,
    format('Time taken: ~3f seconds~n', [Time]),!.
