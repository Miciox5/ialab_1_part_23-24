:- use_module(library(pce)).

% Define a simple predicate to display a message
show_message(Message) :-
    send(@text, clear), % Clear the text before adding a new message
    send(@text, append, Message).

% Define a predicate to be called when the button is pressed
button_action(B) :- 
    send(@prolog, show_message, 'Button Pressed!').

% Main predicate to create the GUI
create_gui :-
    new(P, picture('Sudoku Solver')),
    send(P, open),
    new(@button, button('Press me')),
    send(P, display, @button, point(50, 50)),
    send(@button, message, message(@prolog, button_action, @button)),
    new(@text, text),
    send(P, display, @text, point(50, 100)).

% Call the main predicate to create the GUI
create_gui.
