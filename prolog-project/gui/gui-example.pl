:- use_module(library(pce)).

% Define a simple predicate to display a message
show_message(Message) :-
    send(@text, clear), % Clear the text before adding a new message
    send(@text, append, Message).

draw_cell(Row, Col, Value) :-
    new(Cell, picture),
    send(Cell, display, new(Text, text(Value))),
    send(Cell, size, size(30, 30)),
    send(Cell, position, point(Row * 30, Col * 30)),
    send(Cell, open).

draw_row(Row, Values) :-
    maplist(draw_cell(Row, _, _), Values).

draw_grid(Grid) :-
    maplist(draw_row, Grid).
    

get_grid_values(Grid) :-
    findall(Row, (between(1, 4, Row), get_row_values(Row, RowValues), Grid = [RowValues|_]), _).

get_row_values(Row, RowValues) :-
    findall(Value, (between(1, 4, Col), (piena(pos(Row, Col), Value); vuota(pos(Row, Col), Value))), RowValues).
    

update_gui(Grid) :-
    send(@text, clear),
    send(@text, append, "Sudoku Grid:\n"),
    draw_grid(Grid),
    send(@text, append, "\n"),
    send(@text, append, "Press 'Solve' to solve the puzzle."),
    send(@text, append, "\n").

solve_button_action(B):-
    send(@text, append, "Solving...\n"),
    main,
    % Call your Sudoku solver here
    % ...
    send(@text, append, "Solution found!\n").
    % Update the GUI with the solved grid
    % ...
    

% Main predicate to create the GUI
main_gui:-
    get_grid_values(Grid),
    new(P, picture('Sudoku Solver')),
    send(P, open),
    new(@button, button('Solve')),
    send(P, display, @button, point(50, 50)),
    send(@button, message, message(@prolog, solve_button_action, @button)),
    new(@text, text),
    send(P, display, @text, point(50, 100)),
    update_gui(Grid).


% Call the main predicate to create the GUI
main_gui.
