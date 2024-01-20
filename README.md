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
>**__NOTA__** Per testare gli altri domini, cambiare il file *startProject4x4facile.pl* con le seguenti possibilità:
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

## ATTIVITÀ 2: CLINGO
### Comandi di esecuzione:
Esecuzione di esempio su un dominio con 4 squadre:
```
cd asp-project/
clingo campionato-4squadre.cl 
```
Il risultato è un modello con le tempistiche di esecuzione e le informazioni sulle risorse utilizzate.

>**__NOTA__** Per testare gli altri domini, cambiare il file *campionato-4squadre.cl* con le seguenti possibilità:
>- campionato-4squadre.cl
>- campionato-8squadre.cl
>- campionato-12squadre.cl
>- campionato-16squadre.cl
>- campionato-20squadre.cl
### Introduzione al progetto:
Nel progetto Clingo, è stato implementato un sistema per la generazione di un calendario di partite (andata e ritorno) con i vincoli richiesti dalla traccia.
Sono state fatte varie prove sui seguenti domini:
- un campionato a 4 squadre,
- un campionato a 8 squadre,
- un campionato a 12 squadre,
- un campionato a 16 squadre,
- un campionato a 20 squadre.
Tutto ciò è servito per esaminare il codice creato, analizzare le tempistiche di esecuzione ed ottimizzare alcuni aspetti implementativi.