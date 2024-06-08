### Intelligenza Artificiale e Laboratorio
# Progetto d’esame per la parte programmazione logica/ASP
(docente: Gian Luca Pozzato)

E’ richiesta la realizzazione di un progetto (sviluppato anche in gruppo) che comprende le due attività seguenti descritte nel seguito. Oltre all’implementazione degli esercizi è necessario predisporre una breve presentazione (di circa 10 minuti) accompagnata da slides per la presentazione delle implementazioni realizzate, mettendo in evidenza le scelte di progetto più significative e l’analisi critica dei risultati sperimentali ottenuti con opportune prove. 

## ATTIVITÀ 1: PROLOG
### Comandi di esecuzione:
Esecuzione di esempio del codice:
```
cd prolog-project/
swipl -s startProject4x4facile.pl 
```
>__NOTA__ Per testare gli altri domini, cambiare il file *startProject4x4facile.pl* con le seguenti possibilità:
>- startProject4x4difficile.pl
>- startProject9x9facile.pl
>- startProject9x9difficile.pl

### Introduzione al progetto:
Nel progetto di Prolog, è stato implementato un Sudoku Solver. Sono stati rappresentati 4 domini localizzati nella directory *sudoku/*:
- 4x4 facile,
- 4x4 difficile,
- 9x9 facile,
- 9x9 difficile.

In *azioni.pl* viene implementata una configurazione di predicati che, con forza bruta, cercano di risolvere il sudoku in input.

[ATTIVITÀ 2: ANSWER SET PROGRAMMING IN CLINGO](./asp-project/README.md)
