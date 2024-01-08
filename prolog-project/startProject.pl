% load_file.pl

% This predicate will be called when the file is consulted
:- initialization(main, main).

main :-
    % Replace 'your_file.pl' with the actual name of your Prolog file
    consult("sudokuCasella/dominioCasella.pl"),
    consult("sudokuCasella/azioniCasella.pl"),
    consult("sudokuCasella/strategiaCasella.pl"),
    write('File loaded. Ready to go!\n'),
    % Add any additional initialization or actions here
    % For example, you can start your main program or query user input
    main_program.

main_program :-
    write('This is your main program.\n'),
    % Add your main program logic here
    % For example, you can start your Sudoku solver or other tasks
    % ...
    strategiaDiRicerca(Cammino).
    % If you want to start an interactive shell, you can use the following:
    % prolog.
    % halt.  % Exit SWI-Prolog after executing the main program
