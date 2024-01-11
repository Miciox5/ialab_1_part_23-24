% load_file.pl

% This predicate will be called when the file is consulted
:- initialization(main, main).

main :-
    % Replace 'your_file.pl' with the actual name of your Prolog file
    consult('sudoku/dominio9x9.pl'),
    consult('sudoku/azioni.pl'),
    consult('sudoku/strategia.pl'),
    write('File loaded. Ready to go!\n'),
    % Add any additional initialization or actions here
    % For example, you can start your main program or query user input
    main_program.

main_program :-
    write('This is your main program.\n'),
    % Add your main program logic here
    % Enable tracing
    % trace,
    % Call your predicate with trace enabled
    strategiaDiRicerca(Cammino).
    % If you want to start an interactive shell, you can use the following:
    % prolog.
    % halt.  % Exit SWI-Prolog after executing the main program
    % nodebug.  % Disable tracing before entering the interactive shell
