import tkinter as tk
from tkinter import Toplevel
from pyswip import Prolog


def query_prolog_file(file_path, query):
    prolog = Prolog()
    prolog.consult(file_path)
    result = list(prolog.query(query))
    return result

def get_sudoku_values():
    prolog_file_path = "/home/micio-uni/Scrivania/IALab1/ialab_1_part_23-24/prolog-project/gui/dominio4x4.pl"
    query_string = "cella(pos(Row, Col), Value), Value \\= x."

    result = query_prolog_file(prolog_file_path, query_string)
    return result

def run_sudoku_strategy():
    
    prolog_file_path = "/home/micio-uni/Scrivania/IALab1/ialab_1_part_23-24/prolog-project/sudoku/strategia.pl"
    query_string = "strategiaDiRicerca(Cammino)."
    result = query_prolog_file(prolog_file_path, query_string)

    # Modifica questa parte per gestire il risultato della tua strategia di risoluzione
    # print("Risultato della strategia di risoluzione:", result)

    # Esegui una nuova query per ottenere i valori aggiornati delle celle
    prolog = Prolog()
    updated_values = list(prolog.query("cella(pos(Row, Col), Value)."))
    # updated_values = get_sudoku_values()

    # Apri la nuova finestra con i valori aggiornati
    show_result_window(updated_values)

def show_result_window(result):
    result_window = Toplevel()
    result_window.title("Risultato Sudoku")

    for solution in result:
        row = solution['Row']
        col = solution['Col']
        value = solution['Value']

        label = tk.Label(result_window, text=str(value), font=('Helvetica', 20))
        label.grid(row=row, column=col, padx=50, pady=25)

def create_sudoku_gui():
    root = tk.Tk()
    root.title("Sudoku")

    sudoku_values = get_sudoku_values()

    for solution in sudoku_values:
        row = solution['Row']
        col = solution['Col']
        value = solution['Value']

        label = tk.Label(root, text=str(value), font=('Helvetica', 20))
        label.grid(row=row, column=col, padx=50, pady=25)

    run_button = tk.Button(root, text="Esegui Strategia", command=run_sudoku_strategy)
    run_button.grid(row=5, column=0, columnspan=4, pady=10)

    root.mainloop()

if __name__ == "__main__":
    create_sudoku_gui()
