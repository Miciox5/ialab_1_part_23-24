
:- initialization(main, main).

main :-
    consult("sudoku/dominio4x4difficile.pl"),
    consult("sudoku/azioni.pl"),
    consult("sudoku/strategia.pl"),
    write('File loaded. Ready to go!\n'),
    main_program.

main_program :-
    write('This is your main program.\n'),
    % trace,
    statistics(runtime, [Start|_]),
    strategiaDiRicerca(Cammino),
    write(Cammino),!,
    statistics(runtime, [End|_]),
    % Debug: print start and end times
    format('Start time: ~w ms~n', [Start]),
    format('End time: ~w ms~n', [End]),
    Time is (End - Start) / 1000,
    format('Time taken: ~3f seconds~n', [Time]),!.
    % nodebug,
    % halt 
