% gui.pl

:- use_module(library(pce)).

% Include the Sudoku logic file
:- consult('../sudoku/dominio4x4.pl').

% Create the Sudoku GUI
create_sudoku_window :-
    new(@sudoku, picture('Sudoku')),
    send(@sudoku, open),
    initialize_sudoku_board,
    send(@sudoku, confirm, 'Close Sudoku?', point(0, 0)).

% Initialize the Sudoku board based on the initial configuration
initialize_sudoku_board :-
    new(@table, text),
    send(@table, font, bold),
    create_empty_board,
    findall(pos(Row, Col), (cella(pos(Row, Col), Value), Value \= x), Positions),
    forall(member(pos(Row, Col), Positions), place_value(pos(Row, Col), Value)),
    send(@sudoku, display, @table, point(50, 50)),
    send(@sudoku, flush).

% Create an empty Sudoku board
create_empty_board :-
    forall(between(1, 4, Row),
           forall(between(1, 4, Col),
                  place_value(pos(Row, Col), x)
           )
    ).

% Place a value on the Sudoku board at the specified position
place_value(pos(Row, Col), Value) :-
    ( Value \= x
    -> send(@table, selection, Value, point(Col, Row)) % Place the actual value
    ;  true % Do nothing if the value is 'x' (leaving an empty space)
    ).

% Predicate to start the Sudoku GUI
:- initialization(create_sudoku_window, main).

% Infinite loop to keep the window open
:- repeat, fail.
