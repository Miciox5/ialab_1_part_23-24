### Intelligenza Artificiale e Laboratorio
# Progetto d’esame per la parte programmazione logica/ASP


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
In *azioni-euristiche.pl* è stata implementata l'euristica chiamata *Singoli Ovvi* che permette una risoluzione più veloce ed efficiente, implementando l'informazione nella strategia di ricerca.

In *strategia.pl* è contenuta la strategia di risoluzione, con i predicati di riferimento presi nei file *azioni\*.pl*

## ATTIVITÀ 2: CLINGO
Si richiede l’utilizzo del paradigma ASP (Answer Set Programming) per la generazione con clingo del calendario di una competizione sportiva, in particolare di un campionato avente le seguenti caratteristiche:
- sono iscritte 20 squadre;
- il campionato prevede 38 giornate, 19 di andata e 19 di ritorno NON
simmetriche, ossia la giornata 1 di ritorno non coincide necessariamente con la giornata 1 di andata a campi invertiti;
- ogni squadra fa riferimento ad una città, che offre la struttura in cui la squadra gioca gli incontri in casa;
- ogni squadra affronta due volte tutte le altre squadre, una volta in casa e una volta fuori casa, ossia una volta nella propria città di riferimento e una volta in quella dell’altra squadra;
- Due delle 20 squadre fanno riferimento alla medesima città e condividono la stessa struttura di gioco, quindi non possono giocare entrambe in casa nella stessa giornata. Ovviamente, fanno eccezione le due giornate in cui giocano l’una contro l’altra (derby).
FACOLTATIVO: in aggiunta alle caratteristiche sopra indicate, da considerarsi obbligatorie, si richiede di considerare i seguenti vincoli ulteriori, che si potranno aggiungere (tutti o alcuni) a discrezione del gruppo nel caso non rendano privo di soluzione il problema:
- ciascuna squadra non deve giocare mai più di due partite consecutive in casa o fuori casa;
- la distanza tra una coppia di gare di andata e ritorno è di almeno 10 giornate, ossia se SquadraA vs SquadraB è programmata per la giornata 12, il ritorno SquadraB vs SquadraA verrà schedulato non prima dalla giornata 22.